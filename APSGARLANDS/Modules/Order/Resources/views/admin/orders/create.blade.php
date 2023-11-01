@extends('admin::layout')

@component('admin::components.page.header')
    @slot('title', trans('admin::resource.create', ['resource' => trans('order::orders.orders')]))

    <li><a href="{{ route('admin.orders.index') }}">{{ trans('order::orders.orders') }}</a></li>
    <li class="active">{{ trans('admin::resource.create', ['resource' => trans('order::orders.orders')]) }}</li>
@endcomponent
@section('content')
<div style="background-color: white;">

    @include('order::admin.orders.tabs.general')

</div>
   
       
        {{-- {!! $tabs->render(compact('product')) !!} --}}
        {{-- {!! $tabs->render(compact('orders')) !!} --}}
        
   
@endsection