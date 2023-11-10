import store from "../../store";
export default {
    props: ["customerrewardpoints"],
    data() {
        return {
            show: false,
            reward: {
                redemptionAmount: 0,
                isValidRedemption: false,
                redeemedPoint: null,
                error: { status: false, message: "" },
            },
            settings: this.customerrewardpoints,
            redeemReward_btn: false,
        };
    },

    mounted() {
        setTimeout(() => {
            this.updateRedemptionAmountInCart(null); // to get the redemptionAmount from the sotred session data
        }, 1000);

        if (this.settings.activeRewardPoints > 0) {
            this.show = true;
        } else {
            this.show = false;
        }
    },

    watch: {
        "reward.redemptionAmount": function (newValue, oldValue) {
            this.integerValidation(newValue, oldValue)
            this.hasEnoughOrderAmounToRedeem();
        },
    },

    methods: {
        integerValidation(newValue, oldValue){
            if (newValue !== '' && newValue % 1 !== 0) {
                // If it's a decimal, revert to the old value (an integer)
                this.reward.redeemedPoint = oldValue;
                this.reward.error = {
                    status: true,
                    message:
                        "Decimal Fraction values are not allowed..!",
                };
            }
        },
        
        redeemRewardPoints() {
            this.makeTrueReedemBtn();
            this.hasRedemptionErrors();
        },

        hasRedemptionErrors() {
            
            // isRedemption Not Null Not Empty
            if (this.reward.redeemedPoint >0 && this.reward.redeemedPoint &&  this.reward.redeemedPoint.trim(' ')) {
                this.reward.error = { status: false, message: "" };
            } else {
                this.reward.error = {
                    status: true,
                    message: "Redemption points are empty",
                };
                this.makeFalseReedemBtn();
                return true;
            }
            // isRedemption Not Exceeds Available Points

            if (this.reward.redeemedPoint <= this.settings.activeRewardPoints) {
                this.reward.error = { status: false, message: "" };
            } else {
                this.reward.error = {
                    status: true,
                    message:
                        "Your redemption points exceed the actual points you have.",
                };
                this.makeFalseReedemBtn();
                return true;
            }
            // isRedeedmedPoints With In Max Limit

            if (
                this.reward.error.status != true &&
                this.settings.use_points_per_order >= this.reward.redeemedPoint
            ) {
                this.reward.error = { status: false, message: "" };
            } else {
                this.reward.error = {
                    status: true,
                    message:
                        "The redemption points exceed the allowed maximum limit.",
                };
                this.makeFalseReedemBtn();
                return true;
            }
            
            // isRedeedmedPointsAbove Min Order Limit
            if (
                this.reward.error.status != true &&
                store.state.cart.subTotal.amount >=
                    this.settings.min_order_cart_value_redemption
            ) {
                this.reward.error = { status: false, message: "" };
            } else {
                this.reward.error = {
                    status: true,
                    message:
                        "Minimun order amount is " +
                        this.settings.min_order_cart_value_redemption +
                        " to redeem your reward",
                };
                this.makeFalseReedemBtn();
                return true;
            }

            this.calculateRedemptionAmount();
        },

        calculateRedemptionAmount() {
            this.reward.redemptionAmount =
                this.settings.pointsEquolantCash * this.reward.redeemedPoint;
        },

        hasEnoughOrderAmounToRedeem() {
            if (
                this.reward.redemptionAmount > 0 &&
                this.reward.redemptionAmount <= store.state.cart.total.amount
            ) {
                this.reward.error = { status: false, message: "" };
                this.reward.isValidRedemption = true; //when this value is true then
                this.updateRedemptionAmountInCart(true); //Here ends all the validation
            } else if ((this.reward.redemptionAmount = 0)) {
                this.reward.error = {
                    status: true,
                    message:
                        "The order amount is not sufficient to redeem your reward.",
                };
                this.makeFalseReedemBtn();
                this.updateRedemptionAmountInCart();
            }
        },
        updateRedemptionAmountInCart(type = false) {
            // to skip empty api request, if the user not has rewardpoints
            if (this.settings.activeRewardPoints == 0) {
                this.show = false;
            }

            //## type = true when all validation are successfully validated
            //## type = false, for any validation fails
            //## type = null initial render, to find redemption applied in current session

            var sendDataTosend = null;
            if (type === true) {
                sendDataTosend = {
                    redeemedAmount: this.reward.redemptionAmount,
                    redeemedPoint: this.reward.redeemedPoint,
                    resetSession: false,
                };
            } else if (type === false) {
                this.reward.redeemedAmount = 0;
                this.reward.redeemedPoint = 0;
                sendDataTosend = {
                    redeemedAmount: 0,
                    redeemedPoint: 0,
                    resetSession: false,
                };
            } else {
                sendDataTosend = {
                    redeemedAmount: this.reward.redemptionAmount,
                    redeemedPoint: this.reward.redeemedPoint,
                    resetSession: true,
                };
            }
            $.ajax({
                method: "POST",
                url: route("customerrewardspoints.store"),
                data: sendDataTosend,
                success: (cart) => {
                    store.updateCart(cart);
                    this.reward.redemptionAmount = 0;
                    this.reward.redeemedPoint = null;
                    this.makeFalseReedemBtn();
                },
                error: function (error) {
                    console.error(error);
                    this.makeFalseReedemBtn();
                },
            });
            return false;
        },

        removeReward() {
            $.ajax({
                method: "delete",
                url: route("customerrewardspoints.delete"),
                success: (cart) => {
                    store.updateCart(cart);
                    this.reward.redeemedAmount = 0;
                    this.reward.redeemedPoint = null;
                    this.reward.isValidRedemption = false;
                },
                error: function (error) {
                    console.error(error);
                },
            });
        },
        makeFalseReedemBtn(){
            this.redeemReward_btn = false;
        },
        makeTrueReedemBtn(){
            this.redeemReward_btn = true;
        }
    },
};
