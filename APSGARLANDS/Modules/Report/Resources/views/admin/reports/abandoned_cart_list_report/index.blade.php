@extends('report::admin.reports.layout')

@section('filters')
    <div class="form-group">
        <label for="brand">{{ trans('report::admin.filters.product') }}</label>

        <input type="text" name="product" class="form-control" id="product" value="{{ $request->product }}">
    </div>
    @include('report::admin.reports.filters.from')
    @include('report::admin.reports.filters.to')
@endsection

@section('report_result')
    <h3 class="tab-content-title">
        {{ trans('report::admin.filters.report_types.abandoned_cart_list_report') }}
    </h3>

    <div class="table-responsive">
        <table class="table">
            <thead>
                <tr>
                    <th>{{ trans('report::admin.table.abandoned_products_name') }}</th>
                    <th>{{ trans('report::admin.table.abandoned_products_count') }}</th>
                    <th>{{ trans('report::admin.table.abandoned_rate') }}</th>
                    <th>{{ trans('report::admin.table.abandoned_date') }}</th>

                    <th>{{ trans('report::admin.table.abandoned_customer_name') }}</th>
                    <th>{{ trans('report::admin.table.abandoned_reason') }}</th>

                </tr>
            </thead>

            <tbody>
                @forelse ($report as $abandoned)
                    <tr>
                        <td>
                            {{ $abandoned->slug }}
                        </td>

                        <td>
                            {{ $abandoned->quantity }}
                        </td>
                        <td>
                            {{ $abandoned->rate }}
                        </td>
                        <td>
                            {{ date_format($abandoned->created_at,"d-m-Y")}}
                        </td>
                        <td>
                            {{ $abandoned->first_name }}{{ $abandoned->last_name }}
                        </td>
                        <td>
                            {{ $abandoned->reason }}
                        </td>
                    </tr>
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
