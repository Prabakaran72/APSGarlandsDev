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
            var sendDataTosend=null;
            if (type) {
                sendDataTosend = { redeemedAmount: this.reward.redemptionAmount, redeemedPoint:this.reward.redeemedPoint};
                
            } else {
                this.reward.redeemedAmount = 0;
                this.reward.redeemedPoint = 0;
                sendDataTosend = { redeemedAmount: 0, redeemedPoint: 0};
            }
            $.ajax({
                method: "POST",
                url: route("customerrewardspoints.store"),
                data: sendDataTosend,
                success: (cart) => {
                    // console.log("data", cart);
                    // cart = {...cart, redemptionRewardPoints: {...cart.redemptionRewardPoints, points: this.reward.redeemedPoint}}
                    console.log("cart", cart);
                    store.updateCart(cart);
                },
                error: function (error) {
                    console.error(error);
                },
            });
            return false;
        },

        removeReward(){
            $.ajax({
                method: "delete",
                url: route("customerrewardspoints.delete"),
                success: (cart) => {
                    // console.log("data", cart);
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
