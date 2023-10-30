// import store from "../../store";
// export default {
//     props:[
//         "customerrewardpoints",
//     ],
//     data() {
//         return {
//             show: false,
//             rewardpointbar: "Test@1234556",
//             reward: {
//                 redemptionAmount: 0,
//                 isValidRedemption: false,
//             },
//             rewardPoints: {
//                 activeRewardPoints: 250,
//                 use_points_per_order: 500,
//                 redeemedPoint: 0, //User's input
//                 pointsEquolantCase: 1, //Ex 100 Points equal to 20MYR.SO 1pt :  20/100 ie (.2)
//                 min_order_cart_value_redemption: 150,
//                 currency_value: 10, //if customer can earn rewardpoints, then currency rate
//                 point_value: 1, //if customer can earn rewardpoints, then point values per order amount
//                 redemption_point_value: 10,
//                 redemption_currency_value: 1,
//                 error: { status: false, message: "" },
//             },
//         };
//     },

//     mounted() {
//         setTimeout(() => {
//             this.reward.show = true;
//         });
//     console.log('Component');
//     console.log("customerrewardpoints",customerrewardpoints);
//     },

//     watch: {
//         "rewardPoints.redeemedPoint": function () {
//             this.hasRedemptionErrors();
//         },
//         "reward.redemptionAmount": function () {
//             this.hasEnoughOrderAmounToRedeem();
//         },
//     },

//     methods: {
//         // accept() {
//         //     this.show = false;

//         //     $.ajax({
//         //         method: "DELETE",
//         //         url: route("storefront.cookie_bar.destroy"),
//         //     });
//         // },
//         redeemRewardPoints() {
//             if (!this.hasRedemptionErrors()) {
//                 // console.log(
//                 //     "this.reward.redemptionAmount",
//                 //     this.reward.redemptionAmount
//                 // );
//                 // console.log(
//                 //     "this.reward.redemptionAmount",
//                 //     this.reward.isValidRedemption
//                 // );
//                 // console.log(
//                 //     "cart.reward.redemptionAmount",
//                 //     store.state.cart.rewardpoints.isValidRedemption
//                 // );
//                 if (this.reward.redemptionAmount) {
//                     // update the total order amount
//                     // store.state.cart.total.amount = this.reward.redemptionAmount
//                     //     ? store.state.cart.total.amount -
//                     //       this.reward.redemptionAmount
//                     //     : store.state.cart.total.amount;
//                 }
//             }
//         },

//         calculateRedemptionAmount() {
//             this.reward.redemptionAmount =
//                 this.rewardPoints.pointsEquolantCase *
//                 this.rewardPoints.redeemedPoint;
//         },

//         hasRedemptionErrors() {
//             // isRedemptionNotNullNotEmpty() {
//             if (this.rewardPoints.redeemedPoint) {
//                 this.rewardPoints.error = { status: false, message: "" };
//             } else {
//                 this.rewardPoints.error = {
//                     status: true,
//                     message: "Redemption points are empty",
//                 };
//                 return true;
//             }
//             // isRedemptionNotExceedsAvailablePoints() {
//             if (
//                 this.rewardPoints.redeemedPoint <=
//                 this.rewardPoints.activeRewardPoints
//             ) {
//                 this.rewardPoints.error = { status: false, message: "" };
//             } else {
//                 this.rewardPoints.error = {
//                     status: true,
//                     message:
//                         "Your redemption points exceed the actual points you have.",
//                 };
//                 return true;
//             }
//             // isRedeedmedPointsWithInMaxLimit() {

//             if (
//                 this.rewardPoints.error.status != true &&
//                 this.rewardPoints.use_points_per_order >=
//                     this.rewardPoints.redeemedPoint
//             ) {
//                 this.rewardPoints.error = { status: false, message: "" };
//             } else {
//                 this.rewardPoints.error = {
//                     status: true,
//                     message:
//                         "The redemption points exceed the allowed maximum limit.",
//                 };
//                 return true;
//             }
//             // },
//             // },
//             // isRedeedmedPointsAboveMinOrderLimit() {

//             if (
//                 this.rewardPoints.error.status != true &&
//                 // store.state.cart.subTotal.amount >=
//                     this.rewardPoints.min_order_cart_value_redemption
//             ) {
//                 this.rewardPoints.error = { status: false, message: "" };
//             } else {
//                 this.rewardPoints.error = {
//                     status: true,
//                     message:
//                         "The order amount is not sufficient to redeem your reward.",
//                 };
//                 return true;
//             }
//             // },
//             this.calculateRedemptionAmount();
           
//             // },
//         },

//         hasEnoughOrderAmounToRedeem() {
//             if (
//                 !this.hasRedemptionErrors() &&
//                 this.reward.redemptionAmount 
//                 // &&
//                 // store.state.cart.total.amount &&
//                 // this.reward.redemptionAmount <= store.state.cart.total.amount
//             ) {
//                 this.rewardPoints.error = { status: false, message: "" };
//                 this.reward.isValidRedemption= true; //when this value is true then 
//                 this.updateRedemptionAmountInCart('validUpdate'); //Here ends all the validation
//                 console.log(store.state.cart);
//             } else {
//                 this.rewardPoints.error = {
//                     status: true,
//                     message:
//                         "The order amount is not sufficient to redeem your reward.",
//                 };
//                 this.updateRedemptionAmountInCart();
//             }

//         },
//         updateRedemptionAmountInCart(type = null) {
//             if(type == 'validUpdate')
//             {
//                 // store.state.cart.rewardpoints = {
//                 //     redemptionAmount: this.reward.redemptionAmount,
//                 //     redeemedPoint: this.rewardPoints.redeemedPoint,
//                 //     isValidRedemption: this.reward.isValidRedemption,
//                 // };
//                 return false;
//             }
//             else{
//                 // store.state.cart.rewardpoints = {
//                 //     redemptionAmount: null,
//                 //     redeemedPoint: null,
//                 // };
//                 return true;
//             }
//         },
//     },
// };
