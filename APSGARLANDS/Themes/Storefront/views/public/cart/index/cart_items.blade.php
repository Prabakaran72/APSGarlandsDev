<div class="table-responsive">
    <table class="table table-borderless shopping-cart-table">
        <thead>
            <tr>
                <th>{{ trans('storefront::cart.table.image') }}</th>
                <th>{{ trans('storefront::cart.table.product_name') }}</th>
                <th>{{ trans('storefront::cart.table.unit_price') }}</th>
                <th>{{ trans('storefront::cart.table.quantity') }}</th>
                <th>{{ trans('storefront::cart.table.line_total') }}</th>
                <th>
                   
                        <i class="las la-times"  @click="getCartItemOverall" ></i>
                   
                </th>
            </tr>
        </thead>

        <tbody>
            <tr v-for="cartItem in cart.items" :key="cartItem.id">
                <td>
                    <div class="product-image">
                        <img
                            :src="baseImage(cartItem.product)"
                            :class="{ 'image-placeholder': ! hasBaseImage(cartItem.product) }"
                            alt="product image"
                        >
                    </div>
                </td>

                <td>
                    <a
                        :href="productUrl(cartItem.product)"
                        class="product-name"
                        v-text="cartItem.product.name"
                    >
                    </a>

                    <ul class="list-inline product-options" v-cloak>
                        <li v-for="option in cartItem.options">
                            <label>@{{ option.name }}:</label> @{{ optionValues(option) }}
                        </li>
                    </ul>
                </td>

                <td>
                    <label>{{ trans('storefront::cart.table.unit_price:') }}</label>

                    <span class="product-price" v-html="cartItem.unitPrice.inCurrentCurrency.formatted"></span>
                </td>

                <td>
                    <label>{{ trans('storefront::cart.table.quantity:') }}</label>

                    <div class="number-picker">
                        <div class="input-group-quantity">
                            <button type="button" class="btn btn-number btn-minus" data-type="minus" :disabled="cartItem.qty == 1">
                                <i class="las la-angle-left"></i>
                            </button>

                            <input
                                type="text"
                                :value="cartItem.qty"
                                min="1"
                                :max="cartItem.product.manage_stock ? cartItem.product.qty : ''"
                                class="form-control input-number input-quantity"
                                @input="updateQuantity(cartItem, $event.target.value)"
                                @keydown.up="updateQuantity(cartItem, cartItem.qty + 1)"
                                @keydown.down="updateQuantity(cartItem, cartItem.qty - 1)"
                            >

                            <button type="button" class="btn btn-number btn-plus" data-type="plus">
                                <i class="las la-angle-right"></i>
                            </button>
                        </div>
                    </div>
                </td>

                <td>
                    <label>{{ trans('storefront::cart.table.line_total:') }}</label>

                    <span class="product-price" v-html="cartItem.total.inCurrentCurrency.formatted"></span>
                </td>

                <td>
                        <i class="las la-times" @click="getCartItem(cartItem)"></i>

                    
                </td>
            </tr>
        </tbody>
    </table>
</div>

<div class="modal fade" id="deleteItemModal" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Delete Item</h5>
                    <button type="button" class="close" data-dismiss="modal" @click="getClose" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body" style="display:none">
                    
                    <textarea id="cartItem_copy" class="form-control"></textarea>
                </div>
                <div class="modal-body">
                    <p>Why do you want to delete this item from your cart?</p>
                    <textarea id="deleteReason" class="form-control"></textarea>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" @click="getClose">Close</button>
                    <button type="button" class="btn btn-danger" @click="remove" >Delete</button>
                </div>
            </div>
        </div>
    </div> 
    <div class="modal fade" id="deleteItemModalOverall" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Delete Item</h5>
                    <button type="button" class="close"  aria-label="Close" @click="getCloseOverall">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                
                <div class="modal-body">
                    <p>Why do you want to delete this item from your cart?</p>
                    <textarea id="deleteReasonOverall" class="form-control"></textarea>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" @click="getCloseOverall">Close</button>
                    <button type="button" class="btn btn-danger" @click="clearCart" >Delete</button>
                </div>
            </div>
        </div>
    </div> 
