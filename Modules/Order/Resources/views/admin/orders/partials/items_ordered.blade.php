<div class="items-ordered-wrapper">
    <h3 class="section-title">{{ trans('order::orders.items_ordered') }}</h3>

    <div class="row">
        <div class="col-md-12">
            <div class="items-ordered">
                <div class="table-responsive">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>{{ trans('order::orders.product') }}</th>
                                <th>{{ trans('order::orders.delivery_date') }}</th>
                                <th>{{ trans('order::orders.unit_price') }}</th>
                                <th>{{ trans('order::orders.quantity') }}</th>
                                <th>{{ trans('order::orders.line_total') }}</th>
                            </tr>
                        </thead>

                        <tbody>
                            @foreach ($order->products as $product)
                                <tr>
                                    <td>
                                        @if ($product->trashed())
                                            {{ $product->name }}
                                        @else
                                            <a href="{{ route('admin.products.edit', $product->product->id) }}">{{ $product->name }}</a>
                                        @endif

                                        @if ($product->hasAnyOption())
                                            <br>
                                            @foreach ($product->options as $option)
                                                <span>
                                                    {{ $option->name }}:

                                                    <span>
                                                        @if ($option->option->isFieldType())
                                                            {{ $option->value }}
                                                        @else
                                                            {{ $option->values->implode('label', ', ') }}
                                                        @endif
                                                    </span>
                                                </span>
                                            @endforeach
                                        @endif
                                    </td>
                                    <td>
                                        @php
                                        if($product->delivery_date!=null||$product->delivery_date!=''){
                                    @endphp
                                    {{ $product->delivery_date->format('d-m-Y') }}
                                    @php
                                        }else{
                                            echo '-';
                                        }
                                    @endphp

                                        {{-- @php
                                            if($product->delivery_date!=null||$product->delivery_date!=''){
                                        @endphp
                                        {{ $product->delivery_date->format('Y-m-d') }}
                                       
                                        @php
                                        else{
                                    echo '-';
                                }
                                            }
                                        @endphp --}}
                                    </td>
                                    <td>
                                        {{ $product->unit_price->format() }}
                                    </td>

                                    <td>{{ $product->qty }}</td>

                                    <td>
                                        {{ $product->line_total->format() }}
                                    </td>
                                </tr>
                            @endforeach
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
