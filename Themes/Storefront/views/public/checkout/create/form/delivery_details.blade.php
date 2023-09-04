@auth
{{-- @hasAccess('admin.products.index')
    @php
dd($product);
@endphp

@foreach ($order->products as $product)
                fsdgfsg {{ $product->name }}
                         
                                    @endforeach
            
                           
@endHasAccess --}}
@endauth
<div class="billing-details">
    <h4 class="section-title">{{ trans('storefront::checkout.delivery_details') }}</h4>
<span ><strong>Set a Delivery Date Based On product</strong></span><br>

    {{-- <div class="col-md-9"> --}}

       
    
      <counter
                        v-for="cartItem in cart.items"
                        :key="cartItem.id"
                        :cart-item="cartItem"
                    >
                    </counter>
            {{-- <counter
        v-for="cartItem in cart.items"
        :key="cartItem.id"
        :cart-item="cartItem"
    >
    </counter> --}}
    {{-- <counter
    v-if="index === 0"
    :cart-item="cart.items[0]"
    @watch="$event => (index = $event)"
    /> --}}
    {{-- <counter v-if="index === 0" :cart-item="cart.items[0]" /> --}}
    {{-- <counter :cart-items="cart.items"></counter> --}}
    {{-- <counter :cart-items="cart.items"></counter> --}}
        {{-- <span class="error-message" v-if="errors.has('billing.deliverydate')"
            v-text="errors.get('billing.deliverydate')">
        </span> --}}
        
    {{-- </div> --}}
   
    
</div>


