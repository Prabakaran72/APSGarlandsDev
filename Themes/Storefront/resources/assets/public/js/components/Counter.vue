<template>
  <form @submit.prevent="submitForm">
    <div class="form-group">
      <div style="display: inline-block;" class="col-md-5">
        <span>
          {{ cartItem.product.name }}  qty( {{ cartItem.qty }} )
        </span>
      </div>
      <div style="display: inline-block;" class="col-md-7">
        <input
          type="date"
          :name="'delivery_date[' + cartItem.product.id + ']'"
          :id="'delivery_date[' + cartItem.product.id + ']'"
          v-model="selectedDate"
          :min="minDate"

          class="form-control"
          ref="dateInput"
        />
        <input
          type="hidden"
          :name="'productId[' + cartItem.product.id + ']'"
          :id="'productId[' + cartItem.product.id + ']'"
          :value="cartItem.product.id"
        />
      </div>
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
      selectedDate:'',
      minDate: null,
      maxDate:null,
      isMounted: false, // Add this line to initialize isMounted
    };
  },

  methods: {
    calculateDeliveryDate() {
      const preDay = this.productPreparingDay(this.cartItem.product) + this.isAfternoon();
      const currentDate = new Date();
      currentDate.setDate(currentDate.getDate() + preDay);

      if (this.selectedDate) {
        const selectedDate = new Date(this.selectedDate);
        if (selectedDate >= currentDate) {
          this.deliveryDate = selectedDate.toDateString();
        } else {
          this.deliveryDate = 'Invalid Date';
        }
      } else {
        this.deliveryDate = null;
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
