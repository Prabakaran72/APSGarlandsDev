{{ Form::text('tag_name', trans('blogtag::attributes.tag_name'), $errors, $blogtag, ['labelCol' => 2, 'required' => true]) }}
{{ Form::text('tag_code', trans('blogtag::attributes.tag_code'), $errors, $blogtag, ['labelCol' => 2, 'required' => true]) }}
{{ Form::text('description', trans('blogtag::attributes.description'), $errors, $blogtag, ['labelCol' => 2, 'required' => false]) }}


