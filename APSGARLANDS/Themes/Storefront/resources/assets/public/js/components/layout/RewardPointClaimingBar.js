import store from "../../store";
export default {
    props: ["customerrewardpoints"],
    data() {
        return {
            show: true,
            reward: {
                redemptionAmount: 0,
                isValidRedemption: false,
            },
            rewardPoints: {
                activeRewardPoints: 250,
                use_points_per_order: 500,
                redeemedPoint: 0, //User's input
                pointsEquolantCase: 1, //Ex 100 Points equal to 20MYR.SO 1pt :  20/100 ie (.2)
                min_order_cart_value_redemption: 150,
                currency_value: 10, //if customer can earn rewardpoints, then currency rate
                point_value: 1, //if customer can earn rewardpoints, then point values per order amount
                redemption_point_value: 10,
                redemption_currency_value: 1,
                error: { status: false, message: "" },
            },
        };
    },

    mounted() {
        setTimeout(() => {
            this.reward.show = true;
        });
    },

    watch: {
        'reward.redemptionAmount':function(){
            this.hasEnoughOrderAmounToRedeem();
        },
    },
    
    methods: {
        redeemRewardPoints() {
            if (!this.hasRedemptionErrors()) {
                if (this.reward.redemptionAmount) {
                  
                }
            }
        },

        hasRedemptionErrors() {
            // isRedemptionNotNullNotEmpty() {
            if (this.rewardPoints.redeemedPoint) {
                this.rewardPoints.error = { status: false, message: "" };
            } else {
                this.rewardPoints.error = {
                    status: true,
                    message: "Redemption points are empty",
                };
                return true;
            }
            // isRedemptionNotExceedsAvailablePoints() {
            if (
                this.rewardPoints.redeemedPoint <=
                this.rewardPoints.activeRewardPoints
            ) {
                this.rewardPoints.error = { status: false, message: "" };
            } else {
                this.rewardPoints.error = {
                    status: true,
                    message:
                        "Your redemption points exceed the actual points you have.",
                };
                return true;
            }
            // isRedeedmedPointsWithInMaxLimit() {

            if (
                this.rewardPoints.error.status != true &&
                this.rewardPoints.use_points_per_order >=
                    this.rewardPoints.redeemedPoint
            ) {
                this.rewardPoints.error = { status: false, message: "" };
            } else {
                this.rewardPoints.error = {
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
                this.rewardPoints.error.status != true &&
                // store.state.cart.subTotal.amount >=
                this.rewardPoints.min_order_cart_value_redemption
            ) {
                this.rewardPoints.error = { status: false, message: "" };
            } else {
                this.rewardPoints.error = {
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
                this.rewardPoints.pointsEquolantCase *
                this.rewardPoints.redeemedPoint;
        },

        hasEnoughOrderAmounToRedeem() {
            if (
                !this.hasRedemptionErrors() &&
                this.reward.redemptionAmount
                // &&
                // store.state.cart.total.amount &&
                // this.reward.redemptionAmount <= store.state.cart.total.amount
            ) {
                this.rewardPoints.error = { status: false, message: "" };
                this.reward.isValidRedemption = true; //when this value is true then
                this.updateRedemptionAmountInCart("validUpdate"); //Here ends all the validation
                // console.log(store.state.cart);
            } else {
                this.rewardPoints.error = {
                    status: true,
                    message:
                        "The order amount is not sufficient to redeem your reward.",
                };
                this.updateRedemptionAmountInCart();
            }
        },
        updateRedemptionAmountInCart(type = null) {
            console.log("this.reward.redemptionAmount",this.reward.redemptionAmount);
            if (type == "validUpdate") {
                $.ajax({
                    method: "POST",
                    url: route("customerrewardspoints.store"),
                    data: {redeemedAmount : this.reward.redemptionAmount},
                    success: (cart) => {
                    console.log('data', cart);
                    store.updateCart(cart);
                    },
                    error: function (error) {
                        console.error(error);
                    },
                });
                return false;
            } else {
               this.reward.redeemedAmount = 0;
               this.rewardPoints.redeemedPoint=0;
                return true;
            }
        },
    },
};
