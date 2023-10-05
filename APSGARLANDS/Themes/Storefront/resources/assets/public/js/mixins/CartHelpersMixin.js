import store from '../store';
// import { zipExists } from '../components/checkout/Create';

export default {
    data() {
        return {
            loadingOrderSummary: false,
            shippingMethodName: null,
            applyingCoupon: false,
            couponCode: null,
            couponError: null,
        };
    },

    computed: {
        cart() {
            return store.state.cart;
        },

        cartIsEmpty() {
            return store.cartIsEmpty();
        },

        cartIsNotEmpty() {
            return ! store.cartIsEmpty();
        },

        hasShippingMethod() {
            return store.hasShippingMethod();
        },

        firstShippingMethod() {
            return Object.keys(store.state.cart.availableShippingMethods)[0];
        },

        hasCoupon() {
            return store.state.cart.coupon.code !== undefined;
        },
    },

    methods: {
        applyCoupon() {
            if (! this.couponCode) {
                return;
            }
           // console.log('zipvalue',this.form.billing.zip);
            this.updateTotalFlatRate();
            this.loadingOrderSummary = true;
            this.applyingCoupon = true;
            this.zipExists(this.form.billing.zip);
            $.ajax({
                method: 'POST',
                url: route('cart.coupon.store', { coupon: this.couponCode }),
            }).then((cart) => {
                this.couponCode = null;
                store.updateCart(cart);
                // console.log('form.shipping.zip',this.form.shipping.zip);
                //this.zipExists(newZip); 
            }).catch((xhr) => {
                this.couponError = xhr.responseJSON.message;
            }).always(() => {
                this.loadingOrderSummary = false;
                this.applyingCoupon = false;
            });
        },

        removeCoupon() {
            this.loadingOrderSummary = true;
            this.updateTotalFlatRate();
            this.zipExists(this.form.billing.zip);
            $.ajax({
                method: 'DELETE',
                url: route('cart.coupon.destroy'),
            }).then((cart) => {
                store.updateCart(cart);
            }).catch((xhr) => {
                this.$notify(xhr.responseJSON.message);
            }).always(() => {
                this.loadingOrderSummary = false;
            });
        },

        updateShippingMethod(shippingMethodName) {
            if (! shippingMethodName) {
                return;
            }

            this.loadingOrderSummary = true;

            this.changeShippingMethod(shippingMethodName);
            $.ajax({
                method: 'POST',
                url: route('cart.shipping_method.store', { shipping_method: shippingMethodName }),
            }).then((cart) => {
                store.updateCart(cart);
                this.updateTotalFlatRate();
            }).catch((xhr) => {
                this.$notify(xhr.responseJSON.message);
            }).always(() => {
                this.loadingOrderSummary = false;
            });
        },
    },
};
