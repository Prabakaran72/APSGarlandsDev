{{ Form::text('name', trans('template::attributes.name'), $errors, $template, ['labelCol' => 2, 'required' => true]) }}
{{ Form::wysiwyg('body', trans('template::attributes.body'), $errors, $template, ['labelCol' => 2, 'required' => true]) }}

<div class="row">
    <div class="col-md-8">
        {{ Form::checkbox('is_active', trans('template::attributes.is_active'), trans('template::templates.form.enable_the_template'), $errors, $template) }}
    </div>
</div>
