<div class="row">
    <div class="col-md-8">
        {{ Form::number('minimum_spend', trans('testimonial::attributes.minimum_spend'), $errors, $testimonial, ['min' => 0]) }}
        {{ Form::number('maximum_spend', trans('testimonial::attributes.maximum_spend'), $errors, $testimonial, ['min' => 0]) }}
        {{ Form::select('products', trans('testimonial::attributes.products'), $errors, $products, $testimonial, ['class' => 'selectize prevent-creation', 'data-url' => route('admin.products.index'), 'multiple' => true]) }}
        {{ Form::select('exclude_products', trans('testimonial::attributes.exclude_products'), $errors, $excludeProducts, $testimonial, ['class' => 'selectize prevent-creation', 'data-url' => route('admin.products.index'), 'multiple' => true]) }}
        {{ Form::select('categories', trans('testimonial::attributes.categories'), $errors, $categories, $testimonial, ['class' => 'selectize prevent-creation', 'multiple' => true]) }}
        {{ Form::select('exclude_categories', trans('testimonial::attributes.exclude_categories'), $errors, $categories, $testimonial, ['class' => 'selectize prevent-creation', 'multiple' => true]) }}
    </div>
</div>
