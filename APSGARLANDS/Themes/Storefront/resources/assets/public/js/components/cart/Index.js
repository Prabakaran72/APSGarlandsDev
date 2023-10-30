import store from "../../store";
import CartHelpersMixin from "../../mixins/CartHelpersMixin";
import ProductHelpersMixin from "../../mixins/ProductHelpersMixin";

export default {
    mixins: [CartHelpersMixin, ProductHelpersMixin],

    data() {
        return {
            shippingMethodName: null,
            crossSellProducts: [],
        };
    },

    computed: {
        hasAnyCrossSellProduct() {
            return this.crossSellProducts.length !== 0;
        },
    },

    created() {
        this.$nextTick(() => {
            if (store.state.cart.shippingMethodName) {
                this.changeShippingMethod(store.state.cart.shippingMethodName);
            } else {
                this.updateShippingMethod(this.firstShippingMethod);
            }

            this.fetchCrossSellProducts();
        });
    },

    methods: {
        optionValues(option) {
            let values = [];

            for (let value of option.values) {
                values.push(value.label);
            }

            return values.join(", ");
        },

        updateQuantity(cartItem, qty) {
            if (qty < 1 || this.exceedsMaxStock(cartItem, qty)) {
                return;
            }

            if (isNaN(qty)) {
                qty = 1;
            }

            this.loadingOrderSummary = true;

            cartItem.qty = qty;

            $.ajax({
                method: "PUT",
                url: route("cart.items.update", { cartItemId: cartItem.id }),
                data: { qty: qty || 1 },
            })
                .then((cart) => {
                    store.updateCart(cart);
                })
                .catch((xhr) => {
                    this.$notify(xhr.responseJSON.message);
                })
                .always(() => {
                    this.loadingOrderSummary = false;
                });
        },

        exceedsMaxStock(cartItem, qty) {
            return cartItem.product.manage_stock && cartItem.product.qty < qty;
        },

        remove() {
            var cartItem_copy = $("#cartItem_copy").val();
            let deleteReason = $("#deleteReason").val();
            var cartItem = JSON.parse(cartItem_copy);
            this.loadingOrderSummary = true;
            store.removeCartItem(cartItem);

            if (store.cartIsEmpty()) {
                this.crossSellProducts = [];
            }
            $.ajax({
                type: "POST",
                // datatype:"application/JSON",
                url: route("cart.items.destroy", { cartItemId: cartItem.id }),
                data: { cartItem: cartItem, deleteReason: deleteReason },
            })
                .then((cart) => {
                    store.updateCart(cart);
                })
                .catch((xhr) => {
                    this.$notify(xhr.responseJSON.message);
                })
                .always(() => {
                    this.loadingOrderSummary = false;
                });
            $("#deleteItemModal").modal("hide");
            $("#deleteReason").val("");
        },

        clearCart() {
            var deleteReasonOverall = $("#deleteReasonOverall").val();

            const jsonStr = JSON.stringify(store.state.cart.items);
            const jsonObject = JSON.parse(jsonStr);
            const newArray = [];

            // Iterate through the object properties
            for (const key in jsonObject) {
                if (jsonObject[key].hasOwnProperty("id")) {
                    // const idValue = jsonObject[key].id;
                    const idQtyValue = jsonObject[key].qty;
                    const idProductValue = jsonObject[key].product.id;
                    const idSlugValue = jsonObject[key].product.slug;
                    const idUnitValue = jsonObject[key].unitPrice.amount;

                    const value_arr =
                        idProductValue +
                        "@@@" +
                        idSlugValue +
                        "@@@" +
                        idQtyValue +
                        "@@@" +
                        idUnitValue;
                    newArray.push(value_arr);
                }
            }
            const newArrayvalue = newArray;

            $.ajax({
                method: "POST",
                url: route("cart.clear.store"),
                data: {
                    cartItemList: newArrayvalue,
                    reason_destroy: deleteReasonOverall,
                },
            })
                .then((cart) => {
                    store.updateCart(cart);
                })
                .catch((xhr) => {
                    this.$notify(xhr.responseJSON.message);
                });
            // store.clearCart();
            $("#deleteReasonOverall").modal("hide");
            $("body").removeClass("modal-open");
            $(".modal-backdrop").remove();
        },

        changeShippingMethod(shippingMethodName) {
            this.shippingMethodName = shippingMethodName;
        },

        getCartItem(cartItem) {
            $("#deleteItemModal").modal("show");
            $("#cartItem_copy").val(JSON.stringify(cartItem));
        },
        getCartItemOverall() {
            $("#deleteItemModalOverall").modal("show");
        },
        getClose() {
            $("#deleteItemModal").modal("hide");
            $("#deleteReason").val("");
        },
        getCloseOverall() {
            $("#deleteItemModalOverall").modal("hide");
            $("#deleteReasonOverall").val("");
        },

        fetchCrossSellProducts() {
            $.ajax({
                method: "GET",
                url: route("cart.cross_sell_products.index"),
            })
                .then((crossSellProducts) => {
                    this.crossSellProducts = crossSellProducts;
                })
                .catch((xhr) => {
                    this.$notify(xhr.responseJSON.message);
                });
        },
    },
};
