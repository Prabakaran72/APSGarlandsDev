<div class="row">
    <div class="col-md-8">
        {{ Form::checkbox('razerpay_enabled', trans('setting::attributes.razerpay_enabled'), trans('setting::settings.form.enable_razerpay'), $errors, $settings) }}
        {{ Form::text('translatable[razerpay_label]', trans('setting::attributes.razerpay_label'), $errors, $settings, ['required' => true]) }}
        {{ Form::textarea('translatable[razerpay_description]', trans('setting::attributes.razerpay_description'), $errors, $settings, ['rows' => 3, 'required' => true]) }}

        <div class="{{ old('razerpay_enabled', array_get($settings, 'razerpay_enabled')) ? '' : '' }}" id="razerpay-fields">
            {{ Form::text('razerpay_key_id', trans('setting::attributes.razerpay_key_id'), $errors, $settings, ['required' => true]) }}
            {{ Form::password('razerpay_key_secret', trans('setting::attributes.razerpay_key_secret'), $errors, $settings, ['required' => true]) }}
        </div>
    </div>
</div>
