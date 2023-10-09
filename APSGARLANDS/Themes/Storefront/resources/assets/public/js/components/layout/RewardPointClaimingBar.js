export default {
    data() {
        return {
            show: false,
            form:{
                redemptionAmount: null,
            }
        };
    },

    mounted() {
        setTimeout(() => {
            this.show = true;
        });
    },

    methods: {
        accept() {
            this.show = false;

            $.ajax({
                method: 'DELETE',
                url: route('storefront.cookie_bar.destroy'),
            });
        },
        redeemRewardPoints(){
            // console.log('Redeem points', this.form.redeemptionAmount? this.form.redeemptionAmount:null);
            console.log("redeemRewardPoints",this.form.redeemptionAmount);

      },

    },
};
