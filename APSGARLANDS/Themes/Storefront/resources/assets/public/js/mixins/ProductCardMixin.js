import store from "../store";

export default {
    data() {
        return {
            addingToCart: false,
        };
    },

    computed: {
        productUrl() {
            return route("products.show", this.product.slug);
        },

        hasAnyOption() {
            return this.product.options_count > 0;
        },

        hasNoOption() {
            return !this.hasAnyOption;
        },

        hasBaseImage() {
            return this.product.base_image.length !== 0;
        },

        baseImage() {
            if (this.hasBaseImage) {
                return this.product.base_image.path;
            }

            return `${window.FleetCart.baseUrl}/themes/storefront/public/images/image-placeholder.png`;
        },

        inWishlist() {
            return store.inWishlist(this.product.id);
        },

        inCompareList() {
            return store.inCompareList(this.product.id);
        },
    },

    methods: {
        syncWishlist() {
            store.syncWishlist(this.product.id);
        },

        syncCompareList() {
            store.syncCompareList(this.product.id);
        },

        addToCart() {
            this.addingToCart = true;

            var pre_order_days = this.product.prepare_days;			
		
            var item_qty = "";
             $.ajax({
                   method: 'POST',
                   url: route('cart.items.checkemty'),
               }).then((cart) => {
                   
                   var arr = Object.keys(cart).map(function (key) { return cart[key]; });
                   console.log(arr);
                   
                   
                   console.log(arr[1]);
                   item_qty = arr[1];
                   console.log("item_qty12345"+item_qty);
                   
               
               console.log("item_qty"+item_qty);
               //alert(item_qty);
               
                if(item_qty!=0){

                    var header_prepare_days = $('#header-prepare-days').val();
                   
                }
                else{
                    var header_prepare_days = pre_order_days;
                    
                } 
               
              // alert("header_prepare_days"+header_prepare_days);
            //   alert("pre_order_days"+pre_order_days);
               if((pre_order_days!=header_prepare_days) ){
                   //alert("Pre-Order Product Day Not Match");
                   this.$notify("Pre-Order Product Day Not Match");
                   $('.header-cart').trigger('click');
                   this.addingToCart = false;
               }
               else{

            $.ajax({
                method: "POST",
                url: route("cart.items.store", {
                    product_id: this.product.id,
                    qty: 1,
                }),
            })
                .then((cart) => {
                    store.updateCart(cart);

                    if (document.location.href !== route("cart.index")) {
                        $(".header-cart").trigger("click");
                    }
                })
                .catch((xhr) => {
                    this.$notify(xhr.responseJSON.message);
                })
                .always(() => {
                    this.addingToCart = false;
                });
            }
                
        })
        
        },
    },
};
