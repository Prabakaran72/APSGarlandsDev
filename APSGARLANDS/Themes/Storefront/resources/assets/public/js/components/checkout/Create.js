/* eslint-disable */
import store from "../../store";
import Errors from "../../Errors";
import CartHelpersMixin from "../../mixins/CartHelpersMixin";
import ProductHelpersMixin from "../../mixins/ProductHelpersMixin";
// import Datepicker from 'vuejs-datepicker';
import Datepicker from 'vue2-datepicker';
import 'vue2-datepicker/index.css';
// import { format } from 'date-fns';
// import dateFns from 'date-fns'; // Import date-fns library for date formatting
import { addDays, isBefore } from 'date-fns';


export default {
    mixins: [CartHelpersMixin, ProductHelpersMixin],

    props: [
        "customerEmail",
        "customerPhone",
        "gateways",
        "defaultAddress",
        "addresses",
        "countries",
    ],
    components: {
        Datepicker
    },

    data() {

        return {
            form: {
                customer_email: this.customerEmail,
                customer_phone: this.customerPhone,
                billing: {
                    zip: '',
                },
                shipping: {
                    zip: ''
                },
                pickupstore: [],
                billingAddressId: null,
                shippingAddressId: null,
                localpickupAddressId: null,
                newBillingAddress: false,
                newShippingAddress: false,
                ship_to_a_different_address: false,
                terms_and_conditions: false,

                //RECURRING ORDER
                isCheckedRecurringOrder: false,
                recurring_order_dates: [],
                recurring_selected_dates: [], // To store recurring selected dates
                recurring_format_order_dates: [], //To store recurring dates with format
                maxPreparingDays: 5, // Your max preparing days
                currentDate: new Date(),
                recurring_time: "", // Initialize with the current time
                recurring_selected_date_count: 0,
                initalSubTotal: 0,
            },
            pickupstore: [], // Initialize pickupstore as an empty array
            selectedLocalpickupAddressId: null,
            fixedrate: {
                price: 0,
                total: 0,
            },
            totalFlatRateValue: 0,
            serviceAvailable: true,
            states: {
                billing: {
                    zip: '',
                },
                shipping: {
                    zip: '',
                },
            },

            placingOrder: false,
            errors: new Errors(),
            stripe: null,
            stripeCardElement: null,
            stripeError: null,
            authorizeNetToken: null,
            termsModalContent: "",   //For Terms and Conditions Modal popup
            preparingDays: null,
            selectedDeliveryDate: null,
            minDate: null,
        };
    },

    mounted() {
        // Set the initial value of form.recurring_time to the current time
        this.setCurrentTime();
        this.getLocalpickupAddress();
        if (this.form.shipping_method === 'local_pickup' && this.pickupstore.length > 0) {
            // Check if pickupstore is not empty and shipping method is not 'flat_rate'
            this.selectedLocalpickupAddressId = this.pickupstore[0].id;

            // Find and store the details of the selected address
            this.selectedAddressDetails = this.pickupstore[0];

        }
    },

    computed: {
        stateCodeToNameMapping() {
            return {
                'JHR': 'Johor',
                'KDH': 'Kedah',
                'KTN': 'Kelantan',
                'LBN': 'Labuan',
                'MLK': 'Malacca (Melaka)',
                'NSN': 'Negeri Sembilan',
                'PHG': 'Pahang',
                'PNG': 'Penang (Pulau Pinang)',
                'PRK': 'Perak',
                'PLS': 'Perlis',
                'SBH': 'Sabah',
                'SWK': 'Sarawak',
                'SGR': 'Selangor',
                'TRG': 'Terengganu',
                'PJY': 'Putrajaya',
                'KUL': 'Kuala Lumpur',
            };
        },

        selectedDates() {
            return this.form.recurring_order_dates.map(date => {
                return date.toDateString(); // You can format the date as needed
            });
        },

        RecurringAvailableStartDate() {
            return addDays(this.form.currentDate, this.form.maxPreparingDays);
        },

        shouldDisableCheckbox() {
            // Check if the conditions for disabling the checkbox are met
            return (
                this.form.shipping_method === 'flat_rate' && !this.serviceAvailable
            );
        },

        hasAddress() {
            return Object.keys(this.addresses).length !== 0;
        },

        firstCountry() {
            return Object.keys(this.countries)[0];
        },

        hasBillingStates() {
            return Object.keys(this.states.billing).length !== 0;
        },

        hasShippingStates() {
            return Object.keys(this.states.shipping).length !== 0;
        },

        hasNoPaymentMethod() {
            return Object.keys(this.gateways).length === 0;
        },

        firstPaymentMethod() {
            return Object.keys(this.gateways)[0];
        },

        shouldShowPaymentInstructions() {
            return ["bank_transfer", "check_payment", "razerpay"].includes(
                this.form.payment_method
            );
        },

        paymentInstructions() {
            if (this.shouldShowPaymentInstructions) {
                // console.log('instruction',this.gateways[this.form.payment_method].instructions);
                return this.gateways[this.form.payment_method].instructions;
            }
        },
    },

    watch: {
        pickupstore: {
            handler(newVal) {
                if (newVal.length > 0 && this.selectedLocalpickupAddressId === null) {
                    this.selectedLocalpickupAddressId = newVal[0].id;
                }
            },
            deep: true,
        },
        selectedLocalpickupAddressId(newVal) {
            // Find the selected address in the pickupstore array
            const selectedAddress = this.pickupstore.find(address => address.id === newVal);
            if (selectedAddress) {
                this.selectedAddressDetails = selectedAddress;
            }
        },
        selectedLocalpickupAddressId(newVal) {
            // Check if pickupstore is an array before using the find method
            if (Array.isArray(this.pickupstore)) {
                const selectedAddress = this.pickupstore.find(address => address.id === newVal);
                if (selectedAddress) {
                    this.selectedAddressDetails = selectedAddress;
                }
            }
        },

        "form.isCheckedRecurringOrder": function (newVal) {
            if (!newVal) {
                // Uncheck the isCheckedRecurringOrder checkbox
                this.form.isCheckedRecurringOrder = false;
                this.form.recurring_order_dates = [];
                this.form.recurring_selected_dates = [];
                this.form.recurring_format_order_dates = [];
                this.form.recurring_selected_date_count = 0;
                this.recurringTotalAmountCalc();
            }
        },

        shouldDisableCheckbox(newVal) {
            if (newVal && this.form.terms_and_conditions) {
                // If the checkbox was checked and now becomes disabled, uncheck it
                this.form.terms_and_conditions = false;
            }
        },

        "form.billingAddressId": function () {
            this.mergeSavedBillingAddress();

        },

        "form.shippingAddressId": function () {
            this.mergeSavedShippingAddress();
        },

        "form.billing.city": function (newCity) {
            // if (newCity) {
            //     this.addTaxes();
            // }
        },

        "form.shipping.city": function (newCity) {
            // if (newCity) {
            //     this.addTaxes();
            // }
        },

        "form.billing.zip": function (newZip) {
            if (this.form.newBillingAddress == true) {
                this.zipExists(newZip);
            } else {
                this.zipExists(newZip);
            }
            // console.log("billing zip"+ this.form.billing.zip);
            // if (newZip) {
            //     this.addTaxes();
            // }
        },

        "form.shipping.zip": function (newZip) {
            if (this.form.newShippingAddress == true) {
                this.zipExists(newZip);
            } else {
                this.zipExists(newZip);
            }
            // console.log("shipping zip"+ this.form.shipping.zip);
            // if (newZip) {
            //     this.addTaxes();
            // }
        },
        "newzip": function (newZip) {
            this.zipExists(newZip);
        },

        "form.billing.state": function (newState) {
            // if (newState) {
            //     this.addTaxes();
            // }
        },

        "form.shipping.state": function (newState) {
            // if (newState) {
            //     this.addTaxes();
            // }
        },

        "form.ship_to_a_different_address": function (newValue) {
            if (newValue && this.form.shippingAddressId) {
                this.form.shipping =
                    this.addresses[this.form.shippingAddressId];
            } else {
                this.form.shipping = {};
                this.resetAddressErrors("shipping");
            }

            // this.addTaxes();
        },

        "form.terms_and_conditions": function () {
            this.errors.clear("terms_and_conditions");
        },

        "form.payment_method": function (newPaymentMethod) {
            // console.log('this.form.payment_method',this.form.payment_method);
            if (newPaymentMethod === "paypal") {
                this.$nextTick(this.renderPayPalButton);
            }

            if (newPaymentMethod !== "stripe") {
                this.stripeError = "";
            }
        },

    },

    created() {

        this.getLocalpickupAddress();

        if (this.defaultAddress.address_id) {
            this.form.billingAddressId = this.defaultAddress.address_id;
            this.form.shippingAddressId = this.defaultAddress.address_id;
        }

        if (!this.hasAddress) {
            this.form.newBillingAddress = true;
            this.form.newShippingAddress = true;
        }

        this.$nextTick(() => {
            this.changePaymentMethod(this.firstPaymentMethod);

            if (store.state.cart.shippingMethodName) {
                this.changeShippingMethod(store.state.cart.shippingMethodName);
                this.updateTotalFlatRate();
                this.getLocalpickupAddress();
            } else {
                this.updateShippingMethod(this.firstShippingMethod);
                this.updateTotalFlatRate();
                this.getLocalpickupAddress();
            }

            if (window.Stripe) {
                this.stripe = window.Stripe(FleetCart.stripePublishableKey);

                this.renderStripeElements();
            }
        });
    },

    methods: {
        handleRecurringOrderPayment() {
            if (this.form.isCheckedRecurringOrder) {
                this.form.payment_method = 'razerpay';
                this.form.initalSubTotal = this.cart.subTotal.formatted;
            }
        },

        setCurrentTime() {
            const now = new Date();
            const hours = now.getHours().toString().padStart(2, '0');
            const minutes = now.getMinutes().toString().padStart(2, '0');
            this.form.recurring_time = `${hours}:${minutes}`;
        },

        recurringDateCalc() {

            this.form.recurring_order_dates = this.form.recurring_order_dates || [];

            // Check if this.form.recurring_order_dates is an array before using .length
            // if (Array.isArray(this.form.recurring_order_dates) && this.form.recurring_order_dates.length === 0) {
            //     // document.getElementById('productSubTotal').innerHTML = "MYR&nbsp;" + (this.cart.subTotal.amount).toFixed(2);
            //     return; // Do nothing if form.recurring_order_dates is an empty array
            // }

            this.form.recurring_selected_dates = this.form.recurring_order_dates.slice();

            const formattedDates = this.form.recurring_selected_dates.map(date => {
                const adjustedDate = addDays(date, 1); // Add one day
                return adjustedDate.toISOString().substring(0, 10); // Format as "YYYY-MM-DD"
            });

            this.form.recurring_format_order_dates = formattedDates.join(", ");
            this.form.recurring_selected_date_count = formattedDates.length;
            console.log("recurring_format_order_dates", this.form.recurring_format_order_dates);
            console.log("recurring_selected_date_count", this.form.recurring_selected_date_count);

            this.recurringTotalAmountCalc();
        },

        recurringTotalAmountCalc() {

            const recurringDateCount = parseFloat(this.form.recurring_selected_date_count);

            //TO UPDATE THE SUB TOTAL AMOUNT
            $.ajax({
                method: "POST",
                url: route("recurring.subtotal.update"),
                data: { recurringDateCount: recurringDateCount },
            })
                .then((cart) => {
                    console.log("create js - recurringTotalAmountCalc() - cart", cart);
                    store.updateCart(cart);
                })
                .catch((xhr) => {
                    // this.$notify(xhr.responseJSON.message);
                })
                .always(() => {
                    // this.loadingOrderSummary = false;
                });
        },

        RecurringDisabledDates(date) {
            // Disable dates that are before the available start date
            return isBefore(date, this.RecurringAvailableStartDate);
        },

        getFixedRate(price) {
            $.ajax({
                method: "GET",
                // url: route("admin.fixedrates.getfixedrates", { price: price }), Fixedrate.getpincode
                url: route("Fixedrate.getfixedrates", { price: price }),
                success: (data) => {
                    this.$nextTick(() => {

                        if (price === 0) {
                            document.getElementById('pincode_not_servicable').style.display = 'block';
                            this.serviceAvailable = false;
                            const cartTotalAmount = parseFloat(this.cart.subTotal.amount);
                            let newTotalAmount;
                            if ($.isEmptyObject(this.cart.coupon)) {
                                newTotalAmount = cartTotalAmount;
                            } else {
                                newTotalAmount = cartTotalAmount - parseFloat(this.cart.coupon.value.amount);
                            }

                            // console.log('newTotalAmount', newTotalAmount);
                            const formattedNewTotal = 'MYR ' + newTotalAmount.toFixed(2);

                            this.fixedrate.total = formattedNewTotal;
                            // Update the elements in the DOM
                            const priceFlatRate = document.getElementById('price_flat_rate');
                            const totalFlatRate = document.getElementById('total_flat_rate');
                            if (priceFlatRate) {
                                document.getElementById('price_flat_rate').innerText = 'MYR 0.00';

                            } if (totalFlatRate) {
                                document.getElementById('total_flat_rate').innerText = this.fixedrate.total;
                            }
                            // console.log('Updated total_flat_rate IF CONDITION: ' + this.fixedrate.total);
                            this.updateTotalFlatRate();
                        } else {

                            document.getElementById('pincode_not_servicable').style.display = 'none';
                            this.serviceAvailable = true;
                            const formattedPrice = 'MYR ' + parseFloat(price).toFixed(2);
                            const cartTotalAmount = parseFloat(this.cart.subTotal.amount);
                            let newTotalAmount;

                            if ($.isEmptyObject(this.cart.coupon)) {
                                newTotalAmount = cartTotalAmount + parseFloat(price);
                            } else {
                                // Apply coupon discount if cartCouponAmount is defined
                                newTotalAmount = (cartTotalAmount + parseFloat(price)) - parseFloat(this.cart.coupon.value.amount);
                                // console.log('inside else coupon exists:',newTotalAmount);
                            }

                            // console.log('newTotalAmount', newTotalAmount);
                            const formattedNewTotal = 'MYR ' + newTotalAmount.toFixed(2);
                            this.fixedrate.price = formattedPrice;
                            this.fixedrate.total = formattedNewTotal;
                            const priceFlatRate = document.getElementById('price_flat_rate');
                            const totalFlatRate = document.getElementById('total_flat_rate');
                            if (priceFlatRate) {
                                document.getElementById('price_flat_rate').innerText = this.fixedrate.price;
                            }
                            if (totalFlatRate) {
                                document.getElementById('total_flat_rate').innerText = this.fixedrate.total;
                            }
                            // console.log('Updated total_flat_rate FROM ELSE: ' +parseFloat(price)+'---' +parseFloat(this.cart.subTotal.amount)+'----'+ this.fixedrate.total);
                            this.updateTotalFlatRate();
                        }
                    });
                },
                error: function (error) {
                    console.error(error);
                }
            });
        }
        ,


        zipExists(newZip) {

            // console.log('testing in address',this.cart.shippingcost.amount);
             this.$nextTick(() => {
             $.ajax({
                 method: "GET",
                 url: route("Fixedrate.getpincode"),
                 data: '',
             })
             .then(response => {
           if (response && typeof response === 'object') {
             let zipFound = false;
             // Iterate through the keys of the response object
             for (const key in response) {
                 if (key == newZip) {
                     const price = response[key];
                     const cartTotalAmount = parseFloat(this.cart.subTotal.amount);
                     document.getElementById('pincode_not_servicable').style.display = 'none';
                     this.serviceAvailable= true;
                     let newTotalAmount;

                     if($.isEmptyObject(this.cart.coupon)) {
                         newTotalAmount  =   cartTotalAmount + parseFloat(price);
                     } else {
                         // Apply coupon discount if cartCouponAmount is defined
                         newTotalAmount  =  ( cartTotalAmount + parseFloat(price)) - parseFloat(this.cart.coupon.value.amount);
                         // console.log('inside else coupon exists:',newTotalAmount);
                     }
                     const formattedPrice = 'MYR ' + parseFloat(price).toFixed(2);
                     const formattedNewTotal = 'MYR ' + newTotalAmount.toFixed(2);
                     this.fixedrate.price =formattedPrice;
                     this.fixedrate.total=formattedNewTotal ;
                     // console.log('Updated total_flat_rate FROM ELSE IN ZIP EXISTS: ' +parseFloat(price)+'---' +parseFloat(this.cart.subTotal.amount)+'$----'+ this.fixedrate.total);
                     this.getFixedRate(price);
                     zipFound = true;
                     break;
                 }
                 this.updateTotalFlatRate();

             }

             // If newZip was not found, set this.fixedrate.price to 0
             if (!zipFound) {
                 this.fixedrate.price = 'MYR'+' '+ 0.00;
                 document.getElementById('pincode_not_servicable').style.display = 'block';
                 this.serviceAvailable= false;
                 const cartTotalAmount = parseFloat(this.cart.subTotal.amount);
                 let newTotalAmount;
                        // console.log('if CART COUP : ' + this.cart.coupon + ' COUP AMT : ' + this.cart.coupon.value.amount);

                         if ($.isEmptyObject(this.cart.coupon)) {
                             // Apply coupon discount if cartCouponAmount is defined
                             newTotalAmount = cartTotalAmount
                             // console.log('inside if:',newTotalAmount);
                         } else {
                             newTotalAmount = cartTotalAmount - parseFloat(this.cart.coupon.value.amount);
                         }


                 // console.log('newTotalAmount-from !zipfound', newTotalAmount);
                 const formattedNewTotal = 'MYR ' + newTotalAmount.toFixed(2);
                 this.fixedrate.total = formattedNewTotal;
                 // console.log(`Value for ${newZip} was not found. Setting price to 0.`);
                 // console.log('!ZIPFOUND',this.fixedrate.total);
                 this.getFixedRate(0);
                 this.updateTotalFlatRate();
             }
             const priceFlatRate = document.getElementById('price_flat_rate');
             const totalFlatRate = document.getElementById('total_flat_rate');
             if(priceFlatRate){
                 document.getElementById('price_flat_rate').innerText = this.fixedrate.price;
             }
             if(totalFlatRate){
                 document.getElementById('total_flat_rate').innerText = this.fixedrate.total;
             }
            // console.log('test',document.getElementById('total_flat_rate').innerText);
         } else {
             console.log('Invalid response or missing data in the response.');
         }
     })
     .catch(error => {
         console.error(error);
     });
 });
 } ,
 updateTotalFlatRate() {
    this.recurringTotalAmountCalc();
    // console.log("HI FROM updateTotalFlatRate");
     const totalFlatRateElement = document.getElementById('total_flat_rate');
     this.totalFlatRateValue = this.fixedrate.total;
     this.$nextTick(() => {
     if (totalFlatRateElement) {
         totalFlatRateElement.innerText =  this.totalFlatRateValue;
         // this.getFixedRate(price);
        //  this.recurringTotalAmountCalc();
        // console.log('Updated total_flat_rate: ' + totalFlatRateElement.innerText);
     } else {
        // console.error("Element with ID 'total_flat_rate' not found.");
     }
 });
 },
 getLocalpickupAddress() {
    // console.log("this.form.shipping_method",this.form.shipping_method);
    // console.log('entered');
     // Make an AJAX request to retrieve address details
     $.ajax({
       method: "GET",
      // url: route("admin.pickupstores.getLocalPickupAddress"),Pickupstore.getLocalPickupAddress
       url: route("Pickupstore.getLocalPickupAddress"),
       data: {},
     })
     .then(response => {
        // console.log('Received response:', response);
         this.pickupstore = response; // Set the 'pickupstore' data with the response
         //console.log('this.pickupstore', this.pickupstore);
       })
     .catch(error => {
       console.error(error);
     });
   },



addNewBillingAddress() {
         this.resetAddressErrors("billing");

         this.form.billing = {};
         this.form.newBillingAddress = !this.form.newBillingAddress;

         if (!this.form.newBillingAddress) {
             this.mergeSavedBillingAddress();
         }
     },

     addNewShippingAddress() {
         this.resetAddressErrors("shipping");

         this.form.shipping = {};
         this.form.newShippingAddress = !this.form.newShippingAddress;

         if (!this.form.newShippingAddress) {
             this.mergeSavedShippingAddress();
         }
     },

        // reset address errors based on address type
        resetAddressErrors(addressType) {
            Object.keys(this.errors.errors).map((key) => {
                key.indexOf(addressType) !== -1 && this.errors.clear(key);
            });
        },

        mergeSavedBillingAddress() {
            this.resetAddressErrors("billing");

            if (!this.form.newBillingAddress && this.form.billingAddressId) {
                this.form.billing = this.addresses[this.form.billingAddressId];
            }
        },

        mergeSavedShippingAddress() {
            this.resetAddressErrors("shipping");

            if (
                this.form.ship_to_a_different_address &&
                !this.form.newShippingAddress &&
                this.form.shippingAddressId
            ) {
                this.form.shipping =
                    this.addresses[this.form.shippingAddressId];
            }
        },

        changeBillingCity(city) {
            this.$set(this.form.billing, "city", city);
        },

        changeShippingCity(city) {
            this.$set(this.form.shipping, "city", city);
        },

        changeBillingZip(zip) {
            this.$set(this.form.billing, "zip", zip);
        },

        changeShippingZip(zip) {
            this.$set(this.form.shipping, "zip", zip);
        },

        changeBillingCountry(country) {
            this.$set(this.form.billing, "country", country);

            if (country === "") {
                this.form.billing.state = "";
                this.states.billing = {};

                return;
            }

            this.fetchStates(country, (states) => {
                this.$set(this.states, "billing", states);
                this.$set(this.form.billing, "state", "");
            });
        },

        changeShippingCountry(country) {
            this.$set(this.form.shipping, "country", country);

            if (country === "") {
                this.form.shipping.state = "";
                this.states.shipping = {};

                return;
            }

            this.fetchStates(country, (states) => {
                this.$set(this.states, "shipping", states);
                this.$set(this.form.shipping, "state", "");
            });
        },

        fetchStates(country, callback) {
            $.ajax({
                method: "GET",
                url: route("countries.states.index", { code: country }),
            }).then(callback);
        },

        changeBillingState(state) {
            this.$set(this.form.billing, "state", state);
        },

        changeShippingState(state) {
            this.$set(this.form.shipping, "state", state);
        },

        changePaymentMethod(paymentMethod) {
            this.$set(this.form, "payment_method", paymentMethod);
        },

        changeShippingMethod(shippingMethodName) {
            this.$set(this.form, "shipping_method", shippingMethodName);
        },

        // addTaxes() {
        //     this.loadingOrderSummary = true;

        //     $.ajax({
        //         method: "POST",
        //         url: route("cart.taxes.store"),
        //         data: this.form,
        //     })
        //         .then((cart) => {
        //             store.updateCart(cart);
        //         })
        //         .catch((xhr) => {
        //             this.$notify(xhr.responseJSON.message);
        //         })
        //         .always(() => {
        //             this.loadingOrderSummary = false;
        //         });
        // },

        placeOrder() {
            if (!this.form.terms_and_conditions || this.placingOrder) {
                return;
            }
          //  console.log("this.selectedLocalpickupAddressId",this.selectedAddressDetails);
            this.placingOrder = true;

            // Check if isCheckedRecurringOrder is enabled
            if (this.form.isCheckedRecurringOrder) {
                // Fields are mandatory, focus on the first one
                if (this.form.recurring_order_dates.length === 0 && Array.isArray(this.form.recurring_order_dates)) {
                    this.$refs.recurring_order_dates.focus();
                    return;
                }
            }

            this.placingOrder = true;
            console.log("this.form", this.form);
            $.ajax({
                method: "POST",
                url: route("checkout.create"),
                data: {
                    ...this.form,
                    selectedPickupstoreDetails:
                        this.selectedAddressDetails,
                    ship_to_a_different_address:
                        +this.form.ship_to_a_different_address,
                        delivery_date:this.selectedDeliveryDate,
                },

            })
                .then((response) => {

                    if (response.redirectUrl) {
                        window.location.href = response.redirectUrl;
                    } else if (this.form.payment_method === "razerpay") {
                        console.log("if response.orderId", response.orderId);
                        //console.log("confirmRazerpayPayment");
                        this.confirmRazerpayPayment(response);
                    } else {
                        this.confirmOrder(
                            response.orderId,
                            this.form.payment_method
                        );

                    }
                })
                .catch((xhr) => {
                    if (xhr.status === 422) {
                        this.errors.record(xhr.responseJSON.errors);
                    }
                    // console.log('error',this.form.payment_method);
                    this.$notify(xhr.responseJSON.message);

                    this.placingOrder = false;
                });
        },


        confirmOrder(orderId, paymentMethod, params = {}) {
            // console.log('it s a confirm order function');
            $.ajax({
                method: "GET",
                url: route("checkout.complete.store", {
                    orderId,
                    paymentMethod,
                    ...params,
                }),
            })
                .then(() => {
                    window.location.href = route("checkout.complete.show");
                })
                .catch((xhr) => {
                    this.placingOrder = false;
                    this.loadingOrderSummary = false;

                    this.deleteOrder(orderId);
                    this.$notify(xhr.responseJSON.message);
                });
        },

        deleteOrder(orderId) {
            if (!orderId) {
                return;
            }

            $.ajax({
                method: "GET",
                url: route("checkout.payment_canceled.store", { orderId }),
            }).then((xhr) => {
                this.$notify(xhr.message);
            });
        },

        renderPayPalButton() {
            let vm = this;
            let response;

            window.paypal
                .Buttons({
                    async createOrder() {
                        try {
                            response = await $.ajax({
                                method: "POST",
                                url: route("checkout.create"),
                                data: vm.form,
                            });

                            return response.resourceId;
                        } catch (xhr) {
                            if (xhr.status === 422) {
                                vm.errors.record(xhr.responseJSON.errors);
                            } else {
                                vm.$notify(xhr.responseJSON.message);
                            }
                        }
                    },
                    onApprove() {
                        vm.loadingOrderSummary = true;

                        vm.confirmOrder(response.orderId, "paypal", response);
                    },
                    onError() {
                        vm.deleteOrder(response.orderId);
                    },
                    onCancel() {
                        vm.deleteOrder(response.orderId);
                    },
                })
                .render("#paypal-button-container");
        },

        renderStripeElements() {
            this.stripeCardElement = this.stripe.elements().create("card", {
                hidePostalCode: true,
            });

            this.stripeCardElement.mount("#stripe-card-element");
        },

        async confirmStripePayment({ orderId, clientSecret }) {
            let result = await this.stripe.confirmCardPayment(clientSecret, {
                payment_method: {
                    card: this.stripeCardElement,
                    billing_details: {
                        email: this.form.customer_email,
                        name: `${this.form.billing.first_name} ${this.form.billing.last_name}`,
                        address: {
                            city: this.form.billing.city,
                            country: this.form.billing.country,
                            line1: this.form.billing.address_1,
                            line2: this.form.billing.address_2,
                            postal_code: this.form.billing.zip,
                            state: this.form.billing.state,
                        },
                    },
                },
            });

            if (result.error) {
                this.placingOrder = false;
                this.stripeError = result.error.message;

                this.deleteOrder(orderId);
            } else {
                this.confirmOrder(orderId, "stripe", result);
            }
        },

        confirmPaytmPayment({ orderId, amount, txnToken }) {
            let config = {
                root: "",
                flow: "DEFAULT",
                data: {
                    orderId: orderId,
                    token: txnToken,
                    tokenType: "TXN_TOKEN",
                    amount: amount,
                },
                merchant: {
                    name: FleetCart.storeName,
                    redirect: false,
                },
                handler: {
                    transactionStatus: (response) => {
                        if (response.STATUS === "TXN_SUCCESS") {
                            this.confirmOrder(orderId, "paytm", response);
                        } else if (response.STATUS === "TXN_FAILURE") {
                            this.placingOrder = false;

                            this.deleteOrder(orderId);
                        }

                        window.Paytm.CheckoutJS.close();
                    },
                    notifyMerchant: (eventName) => {
                        if (eventName === "APP_CLOSED") {
                            this.placingOrder = false;

                            this.deleteOrder(orderId);
                        }
                    },
                },
            };

            window.Paytm.CheckoutJS.init(config)
                .then(() => {
                    window.Paytm.CheckoutJS.invoke();
                })
                .catch(() => {
                    this.deleteOrder(orderId);
                });
        },

        confirmRazorpayPayment(razorpayOrder) {
            this.placingOrder = false;

            let vm = this;

            new window.Razorpay({
                key: FleetCart.razorpayKeyId,
                name: FleetCart.storeName,
                description: `Payment for order #${razorpayOrder.receipt}`,
                image: FleetCart.storeLogo,
                order_id: razorpayOrder.id,
                handler(response) {
                    vm.placingOrder = true;

                    vm.confirmOrder(
                        razorpayOrder.receipt,
                        "razorpay",
                        response
                    );
                },
                modal: {
                    ondismiss() {
                        vm.deleteOrder(razorpayOrder.receipt);
                    },
                },
                prefill: {
                    name: `${vm.form.billing.first_name} ${vm.form.billing.last_name}`,
                    email: vm.form.customer_email,
                    contact: vm.form.customer_phone,
                },
            }).open();
        },

        confirmPaystackPayment({
            key,
            email,
            amount,
            ref,
            currency,
            order_id,
        }) {
            let vm = this;

            PaystackPop.setup({
                key,
                email,
                amount,
                ref,
                currency,
                onClose() {
                    vm.placingOrder = false;

                    vm.deleteOrder(order_id);
                },
                callback(response) {
                    vm.placingOrder = false;

                    vm.confirmOrder(order_id, "paystack", response);
                },
                onBankTransferConfirmationPending(response) {
                    vm.placingOrder = false;

                    vm.confirmOrder(order_id, "paystack", response);
                },
            }).openIframe();
        },

        confirmAuthorizeNetPayment(authorizeNetOrder) {
            this.authorizeNetToken = authorizeNetOrder.token;

            this.$nextTick(() => {
                this.$refs.authorizeNetForm.submit();

                this.authorizeNetToken = null;
            });
        },

        confirmFlutterWavePayment({
            public_key,
            tx_ref,
            order_id,
            amount,
            currency,
            payment_options,
            redirect_url,
        }) {
            let vm = this;

            FlutterwaveCheckout({
                public_key,
                tx_ref,
                amount,
                currency,
                payment_options: payment_options.join(", "),
                redirect_url,
                customer: {
                    email: this.form.customer_email,
                    phone_number: this.form.customer_phone,
                    name: this.form.billing.full_name,
                },
                customizations: {
                    title: FleetCart.storeName,
                    logo: FleetCart.storeLogo,
                },
                onclose(incomplete) {
                    vm.placingOrder = false;

                    if (incomplete) {
                        vm.deleteOrder(order_id);
                    }
                },
            });
        },

        confirmMercadoPagoPayment(mercadoPagoOrder) {
            this.placingOrder = false;

            const supportedLocales = {
                en_US: "en-US",
                es_AR: "es-AR",
                es_CL: "es-CL",
                es_CO: "es-CO",
                es_MX: "es-MX",
                es_VE: "es-VE",
                es_UY: "es-UY",
                es_PE: "es-PE",
                pt_BR: "pt-BR",
            };

            const mercadoPago = new MercadoPago(mercadoPagoOrder.publicKey, {
                locale:
                    supportedLocales[mercadoPagoOrder.currentLocale] || "en-US",
            });

            mercadoPago.checkout({
                preference: {
                    id: mercadoPagoOrder.preferenceId,
                },
                autoOpen: true,
            });
        },

        confirmRazerpayPayment(response) {
            const {
                amount,
                country,
                bill_mobile,
                bill_name,
                currency,
                bill_email,
                key,
                orderid,
                redirectedurl,
                ref,
                vcode,
                verifykey
            } = response;


            const url = `${redirectedurl}?amount=${amount}&country=${country}&bill_email=${bill_email}&bill_mobile=${bill_mobile}&bill_name=${bill_name}&currency=${currency}&key=${key}&orderid=${orderid}&ref=${ref}&vcode=${vcode}&verifykey=${verifykey}&callback=?`;
            window.location.href = url;
            // Make a GET request using the Fetch API and handle the response
            // fetch(url)
            //     .then(response => {
            //         if (!response.ok) {
            //             throw new Error('Network response was not ok');
            //         }
            //         return response.json();
            //     })
            //     .then(data => {
            //         // Handle the response data here
            //         console.log(data, 'data');
            //         // You can perform further actions with the response data as needed
            //     })
            //     .catch(error => {
            //         // Handle any errors here
            //         console.error(error);
            //     });
        }

        ,

        openModal(termsUrl) {
            // Make an AJAX request to the Laravel named route
            $.ajax({
                method: "GET",
                url: termsUrl,
                success: (data) => {
                    let terms_condition_html = $(data).find('.custom-page-content').html();
                    // Assign the HTML content to the Vue property
                    this.termsModalContent = terms_condition_html;
                    // Set showTermsModal to true to display the modal
                    // Show the modal
                    $('#terms-modal').modal('show');
                }
            })
                .catch((error) => {
                    console.error(error);
                });
        },

        hideTermsModal() {
            $('#terms-modal').modal('hide');
        },


    },
};
