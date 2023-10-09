{{ Form::text('subscribers', trans('email::attributes.subscribers'), $errors, $email, ['labelCol' => 2, 'required' => true]) }}
{{ Form::text('subject', trans('email::attributes.subject'), $errors, $email, ['labelCol' => 2, 'required' => true]) }}
{{ Form::select('template', trans('email::attributes.template'), $errors, $email, ['labelCol' => 2, 'required' => true]) }}
{{ Form::text('date', trans('email::attributes.date'), $errors, $email, ['labelCol' => 2, 'required' => true]) }}
{{-- {{ Form::select('brand_id', trans('product::attributes.brand_id'), $errors, $brands, $product) }} --}}
<div class="row">
    <div class="col-md-8">
        {{ Form::checkbox('is_active', trans('email::attributes.is_active'), trans('email::emails.form.enable_the_email'), $errors, $email) }}
    </div>
</div>
