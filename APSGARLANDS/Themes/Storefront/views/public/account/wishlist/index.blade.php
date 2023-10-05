@extends('public.account.layout')

@section('title', trans('storefront::account.pages.my_wishlist'))

@section('account_breadcrumb')
    <li class="active">{{ trans('storefront::account.pages.my_wishlist') }}</li>
@endsection
 
@section('panel')
    <my-wishlist inline-template>
        <div class="panel wishlist">
            <div class="panel-header">
                <h4>{{ trans('storefront::account.pages.my_wishlist') }}</h4>

                <div class='wishlistDeleteBtn'>
                    <button class='btn btn-danger' @click="openPopupForMultiSelect()" :disabled="!isAnyCheckboxChecked">Delete Selected Products</button>
                </div>
            </div> 
            
            

            <div class="panel-body" :class="{ loading: fetchingWishlist }" v-cloak>
                <div class="empty-message" v-if="wishlistIsEmpty">
                    <h3 v-if="! fetchingWishlist">
                        {{ trans('storefront::account.wishlist.empty_wishlist') }}
                    </h3>                    
                </div>

                <div class="table-responsive" v-else>
                    <table class="table table-borderless my-wishlist-table">
                        <thead>
                            <tr>
                                <th> <input type="checkbox" v-model="selectAllChecked" @change="selectAllProducts" /> </th>
                                <th>{{ trans('storefront::account.image') }}</th>
                                <th>{{ trans('storefront::account.product_name') }}</th>
                                <th>{{ trans('storefront::account.wishlist.price') }}</th>
                                <th>{{ trans('storefront::account.wishlist.availability') }}</th>
                                <th>{{ trans('storefront::account.action') }}</th>                               
                            </tr>
                        </thead>

                        <tbody>                            
                            <!-- <input type="hidden" id="productID" name="productID" value=" -->
                            <tr v-for="product in products.data" :key="product.id" v-if="product.pivot.is_deleted !== '1'">
                                <!-- <input type="hidden" id="hidRemProdID" name="hidRemProdID" value="product.pivot.id"> -->

                                <td> 
                                    <input type="checkbox" :value="product.id" v-model='selectedProducts'  @change="checkSelectAll"> 
                                </td>

                                <td>
                                    <div class="product-image">
                                        <img :src="baseImage(product)" :class="{ 'image-placeholder': ! hasBaseImage(product) }" alt="product-image">
                                    </div>
                                </td>

                                <td>
                                    <a :href="productUrl(product)" class="product-name">                                       
                                        @{{ product.name }}                                                                                                                    
                                    </a>
                                </td>

                                <td>
                                    <span class="product-price" v-html="product.formatted_price"></span>
                                </td>

                                <td>
                                    <span class="badge badge-success" v-if="product.is_in_stock">
                                        {{ trans('storefront::account.wishlist.in_stock') }}
                                    </span>

                                    <span class="badge badge-danger" v-else>
                                        {{ trans('storefront::account.wishlist.out_of_stock') }}
                                    </span>
                                </td>

                                <td>
                                    <button class="btn btn-delete" @click="openPopup(product)">
                                        <i class="las la-trash"></i>
                                        {{ trans('storefront::account.wishlist.delete') }}                                                                                                                        
                                    </button>
                                </td>
                             

                                <!-- Working code - Almost Working -->                               
                                <!-- <td>
                                    <button class="btn btn-delete" @click="openPopup(product.id)">
                                        <i class="las la-trash"></i>
                                        {{ trans('storefront::account.wishlist.delete') }}                                                                                                                        
                                    </button>

                                    <div v-if="showPopup === product.id" class='Popup'>
                                        <div class='header'>
                                            <h5>Drop Your Reasonnn</h5>
                                            <button @click="closePopup">&times;</button>
                                        </div>
                                        <div class='body'>
                                            <textarea v-model="reason" type='text'></textarea>
                                            <div class='btn'>
                                                <button @click="remove(product.id)">Remove</button>
                                            </div>
                                        </div>
                                    </div>
                                </td> -->


                                 <!-- Working code - Completly Working-->
                                <div id='deleteWishListProduct' class='Popup' data-toggle="modal fade">
                                    <div class='header'>
                                        <h5>Drop Your Reason</h5>
                                        <button id='close'  @click='hideconfirmModal()'>&times;</button>
                                    </div>
                                    <div class='body'>
                                        <textarea name='abort_reason' id="abort_reason" v-model="abortReason" type='text'></textarea>
                                        <div class='btn'>
                                            <button @click="remove()" class='btn btn-danger' :disabled="abortReason.length === 0">Remove</button>                                            
                                        </div>
                                    </div>
                                </div>



                                 <!-- Working code - Completly Working FOR CommonDelete-->
                                 <div id='deleteWishListProducts' class='Popup' data-toggle="modal fade">
                                    <div class='header'>
                                        <h5>Drop Your Reason</h5>
                                        <button @click='hidePopupForMultiSelect()'>&times;</button>
                                    </div>
                                    <div class='body'>
                                        <textarea name='get_reason' id="get_reason" v-model="abortReason2" type='text'></textarea>
                                        <div class='btn'>
                                            <button @click="deleteSelectedProducts()" class='btn btn-danger' :disabled="abortReason2.length === 0">Remove</button>                                            
                                        </div>
                                    </div>
                                </div>


                            </tr>
                        </tbody>
                    </table>
                </div>                
            </div>
            

            <div class="panel-footer">
                <v-pagination
                    :total-page="totalPage"
                    :current-page="currentPage"
                    @page-changed="fetchProducts"
                    v-if="products.total > 20"
                >
                </v-pagination>
            </div>
        </div>
    </my-wishlist>


    

    
    <!-- <script>
        function getData(id) {

            console.log('pro' + id);
           
            if(document.getElementById('get').style.display = 'none') {
                document.getElementById('get').style.display = 'block';
            }
            else {
                document.getElementById('get').style.display = 'none';
            }
        }

        function closeTab() {            
            document.getElementById('get').style.display = 'none';
        }     
        
        
    </script> -->

@endsection
