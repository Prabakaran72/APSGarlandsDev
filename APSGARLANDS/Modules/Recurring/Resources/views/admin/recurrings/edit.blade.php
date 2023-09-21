 @extends('admin::layout')

@component('admin::components.page.header')
    @slot('title', trans('admin::resource.edit', ['resource' => trans('recurring::recurrings.recurring')]))
    {{-- @slot('subtitle') --}}

    <li><a href="{{ route('admin.recurrings.index') }}">{{ trans('recurring::recurrings.recurrings') }}</a></li>
    <li class="active">{{ trans('admin::resource.edit', ['resource' => trans('recurring::recurrings.recurring')]) }}</li>
@endcomponent

@section('content')
    {{-- <form method="POST" action="{{ route('admin.recurrings.update', $recurring) }}" class="form-horizontal" id="recurring-edit-form" novalidate>
        {{ csrf_field() }}
        {{ method_field('put') }}

        {!! $tabs->render(compact('recurring')) !!}
    </form> --}}


    <h2>Sub Order Field 1: {{ $subOrderData['delivery_date'] }}</h2>
    <table style="width: 100%; border-collapse: collapse; text-align: center;">
        <thead>
            <tr style="background-color: #ccc;">
                <th style="border: 1px solid #000; padding: 10px;">Header 1</th>
                <th style="border: 1px solid #000; padding: 10px;">Header 2</th>
                <th style="border: 1px solid #000; padding: 10px;">Header 3</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td style="border: 1px solid #000; padding: 10px;">Row 1, Cell 1</td>
                <td style="border: 1px solid #000; padding: 10px;">Row 1, Cell 2</td>
                <td style="border: 1px solid #000; padding: 10px;">Row 1, Cell 3</td>
            </tr>
            <tr>
                <td style="border: 1px solid #000; padding: 10px;">Row 2, Cell 1</td>
                <td style="border: 1px solid #000; padding: 10px;">Row 2, Cell 2</td>
                <td style="border: 1px solid #000; padding: 10px;">Row 2, Cell 3</td>
            </tr>
            <tr>
                <td style="border: 1px solid #000; padding: 10px;">Row 3, Cell 1</td>
                <td style="border: 1px solid #000; padding: 10px;">Row 3, Cell 2</td>
                <td style="border: 1px solid #000; padding: 10px;">Row 3, Cell 3</td>
            </tr>
        </tbody>
    </table>


@endsection

@include('recurring::admin.recurrings.partials.scripts')
