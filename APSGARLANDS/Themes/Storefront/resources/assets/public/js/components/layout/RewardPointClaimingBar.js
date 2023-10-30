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
            redeemReward_btn: false,
        };
    },

    mounted() {
        setTimeout(() => {
            // this.reward.show = true;
            this.updateRedemptionAmountInCart(null); // to get the redemptionAmount from the sotred session data
        },1000);
        console.log('customerrewardpoints',this.customerrewardpoints);

    },

    watch: {
        "reward.redemptionAmount": function () {
            this.hasEnoughOrderAmounToRedeem();
        },
        "reward.error.status" : function(){
            if(!this.reward.error.status)
            {
                this.redeemReward_btn = false;
            }
            else{
                this.updateRedemptionAmountInCart();
            }
        }
    },

    methods: {
        redeemRewardPoints() {
            this.redeemReward_btn = true;
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
                this.settings.use_points_per_order >= this.reward.redeemedPoint
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
                store.state.cart.subTotal.amount >=
                this.settings.min_order_cart_value_redemption
            ) {
                this.reward.error = { status: false, message: "" };
            } else {
                this.reward.error = {
                    status: true,
                    message:
                        "Minimun order amount is "+ this.settings.min_order_cart_value_redemption+" to redeem your reward",
                };
                return true;
            }
            // },
            console.log("isRedeedmedPointsAboveMinOrderLimit")
            this.calculateRedemptionAmount();

            // },
        },

        calculateRedemptionAmount() {
        console.log('calculateRedemptionAmount');
            this.reward.redemptionAmount =
                this.settings.pointsEquolantCash *
                this.reward.redeemedPoint;
        },

        hasEnoughOrderAmounToRedeem() {
            console.log('hasEnoughOrderAmounToRedeem');
            if (this.reward.redemptionAmount > 0 &&
                this.reward.redemptionAmount <= store.state.cart.total.amount
            ) {
                this.reward.error = { status: false, message: "" };
                this.reward.isValidRedemption = true; //when this value is true then
                this.updateRedemptionAmountInCart(true); //Here ends all the validation
            }             
            else if(this.reward.redemptionAmount = 0) {
                this.reward.error = {
                    status: true,
                    message:
                        "The order amount is not sufficient to redeem your reward.",
                };
                this.updateRedemptionAmountInCart();
            }
        },
        updateRedemptionAmountInCart(type = false) {
            //## type = true when all validation are successfully validated
            //## type = false, for any validation fails
            //## type = null initial render, to find redemption applied in current session 
            console.log("type", type);
            var sendDataTosend=null;
            if (type ===true) {
                sendDataTosend = { redeemedAmount: this.reward.redemptionAmount, redeemedPoint:this.reward.redeemedPoint, resetSession:false};
                
            } else if(type ===false) {
                this.reward.redeemedAmount = 0;
                this.reward.redeemedPoint = 0;
                sendDataTosend = { redeemedAmount: 0, redeemedPoint: 0, resetSession:false};
            }
            else{
                sendDataTosend = { redeemedAmount: this.reward.redemptionAmount, redeemedPoint:this.reward.redeemedPoint, resetSession:true};
            }
            $.ajax({
                method: "POST",
                url: route("customerrewardspoints.store"),
                data: sendDataTosend,
                success: (cart) => {
                    store.updateCart(cart);
                    this.reward.redemptionAmount = 0;
                    this.reward.redeemedPoint = null;
                    this.redeemReward_btn = false;
                },
                error: function (error) {
                    console.error(error);
                    this.redeemReward_btn = false;
                },
            });
            return false;
        },

        removeReward(){
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
    },
};
