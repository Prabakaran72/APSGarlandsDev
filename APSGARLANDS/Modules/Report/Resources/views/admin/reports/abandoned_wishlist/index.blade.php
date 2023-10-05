@extends('report::admin.reports.layout')


@section('filters')
    @include('report::admin.reports.filters.from')
    @include('report::admin.reports.filters.to')
   
    
    <div class="form-group">
        <label for="group">Product Name</label>

        <select name="products" id="products" class="custom-select-black" value="{{ $request->products }}">
           
            <option value="">{{ trans('report::admin.filters.please_select') }}</option>            

            @php
                $uniqueNames = $report->unique('name');
            @endphp

           
            @foreach ($allProductNames as $item)
                @php
                    $formattedProductName = ucwords(strtolower(str_replace('-', ' ', $item)));
                @endphp
                <option value="{{ $formattedProductName }}" {{ $request->products === $formattedProductName ? 'selected' : '' }}>
                    {{ $formattedProductName }}
                </option>
            @endforeach
        </select>

            <!-- @forelse ($uniqueNames as $item)
                <option value="{{ $item->name }}" {{ $request->name === $item->name ? 'selected' : '' }}>
                    {{ $item->name }}                    
                </option>
            @endforeach -->

        <!-- <h5>All Product Names:</h5>
        @foreach ($allProductNames as $productName)
        <h6>{{ ucwords(strtolower(str_replace('-', ' ', $productName))) }}</h6>
        @endforeach -->
    </div>


   
@endsection


@section('report_result')
    <h3 class="tab-content-title">
        {{ trans('report::admin.filters.report_types.abandoned_wishlist') }}
    </h3> 

    <div class="table-responsive">
        <table class="table">
            <thead>
               
                <tr>
                    
                    <!-- <th>{{ trans('report::admin.table.product_id') }}</th> -->
                    <th>{{ trans('report::admin.table.product_name') }}</th>
                    <th>{{ trans('report::admin.table.product_price') }}</th>
                    <th>{{ trans('report::admin.table.user') }}</th>
                    <th>{{ trans('report::admin.table.reason') }}</th>
                    <th>{{ trans('report::admin.table.date') }}</th>
                </tr>
                
            </thead>
        
            <tbody>
                @forelse ($report as $item)  
                    <!-- @if( $item ) -->
                        <tr>
                            <!-- <td>
                                {{ $item->id }}                                                                                                                                                              
                            </td>  -->
                                                    
                            <td>
                                
                                {{ $item->name }}
                            </td>

                            <td>
                                
                                {{ $item->price }}
                            </td>
                            
                            <td>                        
                                {{ $item->first_name }}&nbsp;{{ $item->last_name }}
                            </td>

                            <td>                        
                                {{ $item->reason }}
                            </td>

                            <td>                                                   
                                {{ $item->updated_at->toFormattedDateString()}}  
                            </td>
                        </tr>   
                        <!-- @else    
                        <tr>
                            <td colspan="5">No data available</td>
                        </tr>
                    @endif -->
                @empty
                    <tr>
                        <td class="empty" colspan="8">{{ trans('report::admin.no_data') }}</td>
                    </tr>
                @endforelse
            </tbody>
        </table>

        <div class="pull-right">
            {!! $report->links() !!}
        </div>
    </div>
@endsection
