<div class="row">
<div class="col-md-5">{{ Form::text('first_name', trans('customer::attributes.first_name'), $errors, $customer, ['labelCol' => 3, 'required' => true]) }}</div>
<div class="col-md-6">{{ Form::text('last_name', trans('customer::attributes.last_name'), $errors, $customer, ['labelCol' => 3, 'required' => true]) }}</div>
</div>
<div class="row">
    <div class="col-md-5">{{ Form::email('email', trans('customer::attributes.email'), $errors, $customer, ['labelCol' => 3, 'required' => true]) }}
    </div>
    <div class="col-md-6">{{ Form::text('phone', trans('customer::attributes.phone'), $errors, $customer, ['labelCol' => 3, 'required' => true]) }}</div>
    </div>

 