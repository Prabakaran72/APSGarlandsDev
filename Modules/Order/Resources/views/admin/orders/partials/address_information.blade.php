<div class="address-information-wrapper">
    <h3 class="section-title">{{ trans('order::orders.address_information') }}</h3>

    <div class="row">
        <div class="col-md-6">
            <div class="billing-address">
                <h4 class="pull-left">{{ trans('order::orders.billing_address') }}</h4>

                <span>
                    {{ $order->billing_full_name }}
                    <br>
                    {{ $order->billing_address_1 }}
                    <br>

                    @if ($order->billing_address_2)
                        {{ $order->billing_address_2 }}
                        <br>
                    @endif

                    {{ $order->billing_city }}, {{ $order->billing_state_name }} {{ $order->billing_zip }}
                    <br>
                    {{ $order->billing_country_name }}
                </span>
            </div>
        </div>
       
        <!-- Modal -->
<div class="modal fade" id="editShippingModal" tabindex="-1" role="dialog" aria-labelledby="editShippingModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editShippingModalLabel">{{ trans('order::orders.shipping_address') }}</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <form action="" method="post">
                {{-- {{ route('admin.orders.status.update', $order) }} --}}
                @csrf
                <div class="modal-body">
                    <div class="col-md-6">
                         <div class="shipping-address">
                            {{-- <h4 class="">{{ trans('order::orders.shipping_address') }}</h4> --}}
                            
                            {{-- <form action="" method="post"> --}}
                                {{-- {{ route('update_shipping_address') }} --}}
                              
                                <div class="form-group">
                                    <input type="text" class="form-control" name="shipping_full_name" placeholder="Full Name" value="{{ $order->shipping_full_name }}">
                                </div>
                                <div class="form-group">
                                    <input type="text" class="form-control" name="shipping_address_1" placeholder="Address Line 1" value="{{ $order->shipping_address_1 }}">
                                </div>
                                <div class="form-group">
                                    <input type="text" class="form-control" name="shipping_address_2" placeholder="Address Line 2" value="{{ $order->shipping_address_2 }}">
                                </div>
                                <div class="form-group">
                                    <input type="text" class="form-control" name="shipping_city" placeholder="City" value="{{ $order->shipping_city }}">
                                </div>
                                <div class="form-group">
                                    <input type="text" class="form-control" name="shipping_state_name" placeholder="State" value="{{ $order->shipping_state_name }}">
                                </div>
                                <div class="form-group">
                                    <input type="text" class="form-control" name="shipping_zip" placeholder="ZIP" value="{{ $order->shipping_zip }}">
                                </div>
                                <div class="form-group">
                                    <input type="text" class="form-control" name="shipping_country_name" placeholder="Country" value="{{ $order->shipping_country_name }}" readonly>
                                </div>
                            </form>
                        </div>
                    </div>
                    
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-primary">Save Changes</button>
                </div>
            </form>
        </div>
    </div>
</div>


        <div class="col-md-6">
            <div class="shipping-address">
                <h4 class="pull-left">{{ trans('order::orders.shipping_address') }}</h4>
                
{{-- @php print_r($order); @endphp --}}
                <span>
                    {{ $order->shipping_full_name }}
                    <br>
                    {{ $order->shipping_address_1 }}
                    <br>

                    @if ($order->shipping_address_2)
                        {{ $order->shipping_address_2 }}
                        <br>
                    @endif

                    {{ $order->shipping_city }}, {{ $order->shipping_state_name }} {{ $order->shipping_zip }}
                    <br>
                    {{ $order->shipping_country_name }}
                </span>
            </div>
            <div class="col-md-2">
                <div class="shipping-address">
                    {{-- <h4 class="pull-left mb-4">{{ trans('order::orders.shipping_address') }}</h4> --}}
                    {{-- <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#editShippingModal">
                        Edit 
                    </button> --}}
                    
                </div>
            </div>
        </div> 
        
    </div>
</div>
