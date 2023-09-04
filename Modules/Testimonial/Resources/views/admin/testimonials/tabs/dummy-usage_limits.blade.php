<div class="row">
    <div class="col-md-8">
        {{ Form::number('usage_limit_per_testimonial', trans('testimonial::attributes.usage_limit_per_testimonial'), $errors, $testimonial) }}
        {{ Form::number('usage_limit_per_customer', trans('testimonial::attributes.usage_limit_per_customer'), $errors, $testimonial) }}
    </div>
</div>
