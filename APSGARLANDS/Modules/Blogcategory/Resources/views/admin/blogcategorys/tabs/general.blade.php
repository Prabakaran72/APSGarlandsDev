{{ Form::text('category_name', trans('blogcategory::attributes.category_name'), $errors, $blogcategory, ['labelCol' => 2, 'required' => true]) }}
{{ Form::text('category_code', trans('blogcategory::attributes.category_code'), $errors, $blogcategory, ['labelCol' => 2, 'required' => true]) }}
{{ Form::text('description', trans('blogcategory::attributes.description'), $errors, $blogcategory, ['labelCol' => 2, 'required' => false]) }}


