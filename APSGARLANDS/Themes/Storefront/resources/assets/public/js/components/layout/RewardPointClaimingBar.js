import store from "../../store";
export default {
    props: ["customerrewardpoints"],
    data() {
        return {
            show: true,
            reward: {
                redemptionAmount: 0,
                isValidRedemption: false,
                redeemedPoint: null,
                error: { status: false, message: "" }
            },
            settings: this.customerrewardpoints,
        };
    },

    mounted() {
        setTimeout(() => {
            this.reward.show = true;
        });
        console.log('customerrewardpoints',this.customerrewardpoints);
    },

    watch: {
        "reward.redemptionAmount": function () {
            this.hasEnoughOrderAmounToRedeem();
        },
    },

    methods: {
        redeemRewardPoints() {
            this.hasRedemptionErrors();
        },

        hasRedemptionErrors() {
            // isRedemptionNotNullNotEmpty() {
            if (this.reward.redeemedPoint) {
                this.reward.error = { status: false, message: "" };
            } else {
                this.reward.error = {
                    status: true,
                    message: "Redemption points are empty",
                };
                return true;
            }
            // isRedemptionNotExceedsAvailablePoints() {
            if (
                this.reward.redeemedPoint <=
                this.settings.activeRewardPoints
            ) {
                this.reward.error = { status: false, message: "" };
            } else {
                this.reward.error = {
                    status: true,
                    message:
                        "Your redemption points exceed the actual points you have.",
                };
                return true;
            }
            // isRedeedmedPointsWithInMaxLimit() {

            if (
                this.reward.error.status != true &&
                this.settings.use_points_per_order >=
                    this.reward.redeemedPoint
            ) {
                this.reward.error = { status: false, message: "" };
            } else {
                this.reward.error = {
                    status: true,
                    message:
                        "The redemption points exceed the allowed maximum limit.",
                };
                return true;
            }
            // },
            // },
            // isRedeedmedPointsAboveMinOrderLimit() {

            if (
                this.reward.error.status != true &&
                // store.state.cart.subTotal.amount >=
                this.settings.min_order_cart_value_redemption
            ) {
                this.reward.error = { status: false, message: "" };
            } else {
                this.reward.error = {
                    status: true,
                    message:
                        "The order amount is not sufficient to redeem your reward.",
                };
                return true;
            }
            // },
            this.calculateRedemptionAmount();

            // },
        },

        calculateRedemptionAmount() {
            this.reward.redemptionAmount =
                this.settings.pointsEquolantCase *
                this.reward.redeemedPoint;
        },

        hasEnoughOrderAmounToRedeem() {
            console.log(' this.reward.redemptionAmount', this.reward.redemptionAmount);
            console.log('store.state.cart.total.amount', store.state.cart.total.amount);
            if (this.reward.redemptionAmount &&
                this.reward.redemptionAmount <= store.state.cart.total.amount
            ) {
                this.reward.error = { status: false, message: "" };
                this.reward.isValidRedemption = true; //when this value is true then
                this.updateRedemptionAmountInCart(true); //Here ends all the validation
            } else {
                this.reward.error = {
                    status: true,
                    message:
                        "The order amount is not sufficient to redeem your reward.",
                };
                this.updateRedemptionAmountInCart();
            }
        },
        updateRedemptionAmountInCart(type = false) {
            console.log("updateRedemptionAmountInCart - type - ", type);
            if (type) {
                $.ajax({
                    method: "POST",
                    url: route("customerrewardspoints.store"),
                    data: { redeemedAmount: this.reward.redemptionAmount },
                    success: (cart) => {
                        console.log("data", cart);
                        store.updateCart(cart);
                    },
                    error: function (error) {
                        console.error(error);
                    },
                });
                return false;
            } else {
                this.reward.redeemedAmount = 0;
                this.reward.redeemedPoint = 0;
                return true;
            }
        },

        removeReward(){
            $.ajax({
                method: "delete",
                url: route("customerrewardspoints.delete"),
                success: (cart) => {
                    console.log("data", cart);
                    store.updateCart(cart);
                    this.reward.redeemedAmount = 0;
                    this.reward.redeemedPoint = null;
                    this.reward.isValidRedemption = false;
                },
                error: function (error) {
                    console.error(error);
                },
            });
            console.log("after clear reward this.reward.redeemedPoint", this.reward.redeemedPoint);
        },
    },
};
