import store from '../../../store';
import VPagination from '../../VPagination.vue';
import ProductHelpersMixin from '../../../mixins/ProductHelpersMixin';

export default {
    components: { VPagination },

    mixins: [
        ProductHelpersMixin,
    ],

    data() {
        return {
            fetchingWishlist: false,  
            products: { data: [] },  
            currentPage: 1,  
            productToBeClear:{ product_id:'', user_id:'', reason:''},  
            selectedProducts: [],    
            isAnyCheckboxChecked: false, // Add this property   
            selectAll: false, // Initially, set it to false   
            selectAllChecked: false,  
            abortReason: '', // Initialize abortReason as an empty string  
            abortReason2: '', // Initialize abortReason as an empty string  
        };
    },

    computed: {
         // Computed property to check if all individual checkboxes are checked
        isAllChecked: {
            get() {
            return this.selectedProducts.length === this.products.data.length;
            },
            set(value) {
            // Set the selectedProducts based on isAllChecked
            this.selectedProducts = value ? this.products.data.map(product => product.id) : [];
            },
        },

        wishlistIsEmpty() {
            return this.products.data.length === 0;
        },

        totalPage() {
            return Math.ceil(this.products.total / 20);
        },
    },

    watch: {
        selectedProducts: {
            handler() {
                // Check if any checkbox is checked
                this.isAnyCheckboxChecked = this.selectedProducts.length > 0;
            },
            deep: true,
        },
    },

    created() {
        this.fetchWishlist();
    },

    methods: {
        selectAllProducts() {
            // Toggle the selected state of all products based on selectAllChecked
            this.selectedProducts = this.selectAllChecked ? this.products.data.map(product => product.id) : [];
        },
        checkSelectAll() {
            // Check if any of the individual checkboxes is unchecked
            this.selectAllChecked = this.isAllChecked;
          },
        
        fetchWishlist() {
            this.fetchingWishlist = true;

            $.ajax({
                method: 'GET',
                url: route('wishlist.products.index', {
                    page: this.currentPage,
                }),
            }).then((products) => {
                this.products = products;
            }).catch((xhr) => {
                this.$notify(xhr.responseJSON.message);
            }).always(() => {
                this.fetchingWishlist = false;
            });
        },


        openPopup(wish_product){                        
            this.productToBeClear.product_id = wish_product.id;
                        
            $("#deleteWishListProduct").modal("show");
        },
        hideconfirmModal(){
            this.abortReason = ''; // Clear the textarea value
            $('#deleteWishListProduct').modal('hide');                   
        },
        
        

        openPopupForMultiSelect() {                                  
            $("#deleteWishListProducts").modal("show");           
        },
        hidePopupForMultiSelect(){
            this.abortReason2 = ''; // Clear the textarea value
            $('#deleteWishListProducts').modal('hide'); 
            
        },

       
        deleteSelectedProducts() {      
            
            // this.products.data.splice(this.products.data.indexOf(this.productToBeClear), 1);
            // this.products.total--;

            let productsId = this.selectedProducts;            
            let commonReason = $("#get_reason").val();
            this.productToBeClear.reason = commonReason;

            productsId.forEach(productId => {
                const index = this.products.data.findIndex(product => product.id === productId);
                if (index !== -1) {
                    this.products.data.splice(index, 1);
                    this.products.total--;
                }
            });

            console.log('this.productToBeClear ', this.productToBeClear);  

            store.removeMultiDatasFromWishlist(productsId,this.productToBeClear.reason);
                        
            $('#deleteWishListProducts').modal('hide');     
            this.abortReason2 = ''; // Clear the textarea value   
            
            this.isAnyCheckboxChecked = false;
        },       
        
        
        remove() {                        
            // this.products.data.splice(this.products.data.indexOf(this.productToBeClear), 1);
            // this.products.total--; 
                        
            let desc = $("#abort_reason").val();                          
            this.productToBeClear.reason = desc;
                     
            this.products.data = this.products.data.filter(product => product.id !== this.productToBeClear.product_id);
            this.products.total--; 
                                                       
            store.removeFromWishlist(this.productToBeClear.product_id, this.productToBeClear);   
            
            $('#deleteWishListProduct').modal('hide');
            this.abortReason = ''; // Clear the textarea value

            this.isAnyCheckboxChecked = false;
        }, 
        
        
        toggleSelectAll() {            

            this.selectAll = !this.selectAll;
            
            if (this.selectAll) {
              this.selectedProducts = this.products.data.map((product) => product.id);
            } else {
              this.selectedProducts = [];
            }
          },
    },
};
