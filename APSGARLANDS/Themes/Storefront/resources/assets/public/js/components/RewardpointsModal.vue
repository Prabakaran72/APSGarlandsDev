<template>
  <form @submit.prevent="submitForm">
    <div class="form-group">
      Rewardpoints
    </div>
  </form>
</template>

<script>
import CartHelpersMixin from "../mixins/CartHelpersMixin";
import ProductHelpersMixin from '../mixins/ProductHelpersMixin';

export default {
  mixins: [CartHelpersMixin, ProductHelpersMixin],
  props: ['cartItem'],

  data() {
    return {
      activeRewardpoints: null, // User's active rewardpoint
      maxRewardpointsLimit: null, //Maximum allowed rewardpoint to claim per order
      usersRedemptionPoint: null, //User's input is stored 
      rewardpointsRedemptionEnabled: null, //if it true then only allow the user to redeem
      ponitsEquivalentCash : null, // redemption points per case. ie., 50 points equal to 10 MYR       
      isMounted: false, // Add this line to initialize isMounted
    };
  },

  methods: {
    calculatePriceDetuctionOnRedepmtion()
    {
       if(this.activeRewardpoints >= this.usersRedemptionPoint &&
        this.usersRedemptionPoint <= this.maxRewardpointsLimit &&
        this.rewardpointsRedemptionEnabled == true )
       {
          
       }
    },

    submitForm() {
      // Your submitForm logic here
    },
  },

  mounted() {
    const readonlyDateInput = this.$refs.dateInput;
    readonlyDateInput.addEventListener('focus', () => {
      readonlyDateInput.click();
    });

    const preDay = this.productPreparingDay(this.cartItem.product) + this.isAfternoon();
    const currentDate = new Date();
    currentDate.setDate(currentDate.getDate() + preDay);
    const formattedDate = currentDate.toISOString().split('T')[0];
    this.minDate = formattedDate;
    // this.maxDate=formattedDate.setDate(formattedDate.getDate() + preDay);
    this.selectedDate =formattedDate;
console.log('this.minDate',this.selectedDate);
    this.isMounted = true;
  },
};
</script>
