@extends('report::admin.reports.layout')

@section('report_result')
    <h3 class="tab-content-title">
        {{ trans('report::admin.filters.report_types.taxed_products_report') }}
    </h3>

    <div class="table-responsive">
        <table class="table">
            <thead>
                <tr>
                    <th>{{ trans('report::admin.table.tax_class') }}</th>
                    <th>{{ trans('report::admin.table.products_count') }}</th>
                </tr>
            </thead>

            <tbody>
                @forelse ($report as $taxClass)
                    <tr>
                        <td>
                            {{ $taxClass->label }}
                        </td>

                        <td>
                            {{ $taxClass->products_count }}
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
