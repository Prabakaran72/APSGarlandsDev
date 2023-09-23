 @extends('admin::layout')

 @component('admin::components.page.header')
     @slot('title', trans('admin::resource.edit', ['resource' => trans('recurring::recurrings.recurring')]))
     {{-- @slot('subtitle') --}}

     <li><a href="{{ route('admin.recurrings.index') }}">{{ trans('recurring::recurrings.recurrings') }}</a></li>
     <li class="active">{{ trans('admin::resource.edit', ['resource' => trans('recurring::recurrings.recurring')]) }}</li>
 @endcomponent

 @section('content')

 <form method="POST" action="{{ route('admin.recurrings.update', $id) }}" class="form-horizontal" id="recurring-edit-form" novalidate>
    {{ csrf_field() }}
    {{ method_field('put') }}

    {!! $tabs->render(compact('recurring')) !!}
</form>
     <div style="display: flex; flex-direction: row;">
         <div style="flex: 0.2; text-align: left; padding-right: 15px;">
             <p>Recurring Main Id</p>
             <p>Customer Name</p>
             <p>Recurring Email</p>
             <p>Expected Delivery Time</p>
             <p>Over All Status</p>
         </div>
         <div style="flex: 1; text-align: left; padding-left: 10px;">
             <p>{{ $id }}</p>
             <p>{{ $user_first_name . '   ' . $user_last_name }}</p>
             <p>{{ $user_email }}</p>
             <p>{{ $recurring_main_order->delivery_time }}</p>
             <p>{{ $recurring_main_order->delivery_time }}</p>
         </div>
     </div>

     <br><br>

     <table style="width: 100%; border-collapse: collapse; text-align: center;">
         <thead>
             <tr style="background-color: #ccc;">
                 <th style="border: 1px solid #000; padding: 10px;">S.NO</th>
                 <th style="border: 1px solid #000; padding: 10px;">Order Id</th>
                 <th style="border: 1px solid #000; padding: 10px;">Order Date</th>
                 <th style="border: 1px solid #000; padding: 10px;">Delivery Date</th>
                 <th style="border: 1px solid #000; padding: 10px;">Status</th>
             </tr>
         </thead>
         <tbody>
             @foreach ($recurring_main_order->recurring_sub_datas as $sub_data)
                 <tr>
                     <td style="border: 1px solid #000; padding: 10px;">{{ $sub_data->order_id }}</td>
                     <td style="border: 1px solid #000; padding: 10px;">{{ $sub_data->order_id }}</td>
                     <td style="border: 1px solid #000; padding: 10px;">{{ $sub_data->order_date }}</td>
                     <td style="border: 1px solid #000; padding: 10px;">{{ $sub_data->delivery_date }}</td>
                     <td style="border: 1px solid #000; padding: 10px;">
                    <button>Unsubscriped</button>
                    </td>
                 </tr>
             @endforeach
         </tbody>
     </table>
 @endsection

 @include('recurring::admin.recurrings.partials.scripts')

