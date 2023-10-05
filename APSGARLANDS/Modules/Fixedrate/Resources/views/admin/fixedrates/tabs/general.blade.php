{{ Form::text('pincode', trans('fixedrate::attributes.pincode'), $errors, $fixedrate, ['labelCol' => 2, 'required' => true]) }}
{{ Form::text('flat_price', trans('fixedrate::attributes.flat_price'), $errors, $fixedrate, ['labelCol' => 2, 'required' => true]) }}

<div class="row">
    <div class="col-md-8">
        {{ Form::checkbox('is_active', trans('fixedrate::attributes.is_active'), trans('fixedrate::fixedrates.form.enable_the_fixedrate'), $errors, $fixedrate) }}
    </div>
</div>
