<div class="row">
    <div class="col-md-8">
        {{ Form::checkbox('razerpay_enabled', trans('setting::attributes.razerpay_enabled'), trans('setting::settings.form.enable_razerpay'), $errors, $settings) }}
        {{ Form::text('translatable[razerpay_label]', trans('setting::attributes.razerpay_label'), $errors, $settings, ['required' => true]) }}
        {{ Form::textarea('translatable[razerpay_description]', trans('setting::attributes.razerpay_description'), $errors, $settings, ['rows' => 3, 'required' => true]) }}
        {{ Form::checkbox('razerpay_test_mode', trans('setting::attributes.razerpay_test_mode'), trans('setting::settings.form.use_sandbox_for_test_payments'), $errors, $settings) }}
        <div class="{{ old('razerpay_enabled', array_get($settings, 'razerpay_enabled')) ? '' : 'hide' }}" id="razerpay-fields">
            {{ Form::text('razerpay_key_id', trans('setting::attributes.razerpay_key_id'), $errors, $settings, ['required' => true]) }}
            {{ Form::password('razerpay_key_secret', trans('setting::attributes.razerpay_key_secret'), $errors, $settings, ['required' => true]) }}
            {{ Form::text('razerpay_url', trans('setting::attributes.razerpay_url'), $errors, $settings, ['required' => true]) }}
            {{ Form::text('razerpay_merchant_id', trans('setting::attributes.razerpay_merchant_id'), $errors, $settings, ['required' => true]) }}
            {{ Form::textarea('razerpay_instructions', trans('setting::attributes.razerpay_instructions'), $errors, $settings, ['rows' => 3,'required' => true]) }}
        </div>
    </div>
</div>
