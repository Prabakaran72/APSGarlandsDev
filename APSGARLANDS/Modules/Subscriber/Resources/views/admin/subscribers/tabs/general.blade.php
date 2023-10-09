{{ Form::text('email', trans('subscriber::attributes.email'), $errors, $subscriber, ['labelCol' => 2, 'required' => true]) }}
{{ Form::text('body', trans('subscriber::attributes.body'), $errors, $subscriber, ['labelCol' => 2, 'required' => true]) }}

<div class="row">
    <div class="col-md-8">
        {{ Form::checkbox('is_active', trans('subscriber::attributes.is_active'), trans('subscriber::subscribers.form.enable_the_subscriber'), $errors, $subscriber) }}
    </div>
</div>
