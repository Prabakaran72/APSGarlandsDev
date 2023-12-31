<?php

namespace Modules\Setting\Http\Requests;

use Modules\Support\Locale;
use Modules\Support\Country;
use Modules\Support\TimeZone;
use Modules\Currency\Currency;
use Illuminate\Validation\Rule;
use Modules\Core\Http\Requests\Request;

class UpdateSettingRequest extends Request
{
    /**
     * Available attributes.
     *
     * @var string
     */
    protected $availableAttributes = 'setting::attributes';

    /**
     * Array of attributes that should be merged with null
     * if attribute is not found in the current request.
     *
     * @var array
     */
    private $shouldCheck = ['sms_order_statuses', 'email_order_statuses'];


    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        return [
            'supported_countries.*' => ['required', Rule::in(Country::codes())],
            'default_country' => 'required|in_array:supported_countries.*',
            'supported_locales.*' => ['required', Rule::in(Locale::codes())],
            'default_locale' => 'required|in_array:supported_locales.*',
            'default_timezone' => ['required', Rule::in(TimeZone::all())],
            'customer_role' => ['required', Rule::exists('roles', 'id')],
            'supported_currencies.*' => ['required', Rule::in(Currency::codes())],
            'default_currency' => 'required|in_array:supported_currencies.*',

            'translatable.store_name' => 'required',
            'store_phone' => ['required'],
            'store_email' => 'required|email',
            'store_country' => ['required', Rule::in(Country::codes())],

            'fixer_access_key' => 'required_if:currency_rate_exchange_service,fixer',
            'forge_api_key' => 'required_if:currency_rate_exchange_service,forge',
            'currency_data_feed_api_key' => 'required_if:currency_rate_exchange_service,currency_data_feed',
            'auto_refresh_currency_rates' => 'required|boolean',
            'auto_refresh_currency_rate_frequency' => ['required_if:auto_refresh_currency_rates,1', Rule::in($this->refreshFrequencies())],

            'sms_service' => ['nullable', Rule::in($this->smsServices())],
            'vonage_key' => ['required_if:sms_service,vonage'],
            'vonage_secret' => ['required_if:sms_service,vonage'],
            'twilio_sid' => ['required_if:sms_service,twilio'],
            'twilio_token' => ['required_if:sms_service,twilio'],
            'sms_order_statuses.*' => ['nullable', Rule::in($this->orderStatuses())],

            'mail_from_address' => 'nullable|email',
            'mail_encryption' => ['nullable', Rule::in($this->mailEncryptionProtocols())],

            'newsletter_enabled' => ['required', 'boolean'],
            'mailchimp_api_key' => ['required_if:newsletter_enabled,1'],
            'mailchimp_list_id' => ['required_if:newsletter_enabled,1'],

            'facebook_login_enabled' => 'required|boolean',
            'facebook_login_app_id' => 'required_if:facebook_login_enabled,1',
            'facebook_login_app_secret' => 'required_if:facebook_login_enabled,1',

            'google_login_enabled' => 'required|boolean',
            'google_login_client_id' => 'required_if:google_login_enabled,1',
            'google_login_client_secret' => 'required_if:google_login_enabled,1',

            'free_shipping_enabled' => 'required|boolean',
            'free_shipping_min_amount' => 'nullable|numeric',
            'translatable.free_shipping_label' => 'required_if:free_shipping_enabled,1',

            'local_pickup_enabled' => 'required|boolean',
            'translatable.local_pickup_label' => 'required_if:local_pickup_enabled,1',
            'local_pickup_cost' => ['required_if:local_pickup_enabled,1', 'nullable', 'numeric'],

            'flat_rate_enabled' => 'required|boolean',
            'translatable.flat_rate_label' => 'required_if:flat_rate_enabled,1',
            
            // 'flat_rate_cost' => '',
            'flat_rate_cost' => ['required_if:flat_rate_enabled,1', 'nullable', 'numeric'],

            'razerpay_enabled' => 'required|boolean',
            'translatable.razerpay_label' => 'required_if:razerpay_enabled,1',
            'translatable.razerpay_description' => 'required_if:razerpay_enabled,1',
            'razerpay_test_mode' => 'required|boolean',
            'razerpay_key_id' => 'required_if:razerpay_enabled,1',
            'razerpay_key_secret' => 'required_if:razerpay_enabled,1',
            'razerpay_url'=> 'required_if:razerpay_enabled,1',
            'razerpay_merchant_id'=> 'required_if:razerpay_enabled,1',
            'razerpay_instructions'=> 'required_if:razerpay_enabled,1',

            'cod_enabled' => 'required|boolean',
            'translatable.cod_label' => 'required_if:cod_enabled,1',
            'translatable.cod_description' => 'required_if:cod_enabled,1',

            'bank_transfer_enabled' => 'required|boolean',
            'translatable.bank_transfer_label' => 'required_if:bank_transfer_enabled,1',
            'translatable.bank_transfer_description' => 'required_if:bank_transfer_enabled,1',
            'translatable.bank_transfer_instructions' => 'required_if:bank_transfer_enabled,1',

            'check_payment_enabled' => 'required|boolean',
            'translatable.check_payment_label' => 'required_if:check_payment_enabled,1',
            'translatable.check_payment_description' => 'required_if:check_payment_enabled,1',
            'translatable.check_payment_instructions' => 'required_if:check_payment_enabled,1',
        ];
    }


    /**
     * Returns currency rate refresh frequencies..
     *
     * @return array
     */
    private function refreshFrequencies()
    {
        return array_keys(trans('setting::settings.form.auto_refresh_currency_rate_frequencies'));
    }


    /**
     * Returns SMS services.
     *
     * @return array
     */
    private function smsServices()
    {
        return array_keys(trans('sms::services'));
    }


    /**
     * Returns order statuses.
     *
     * @return array
     */
    private function orderStatuses()
    {
        return array_keys(trans('order::statuses'));
    }


    /**
     * Returns mail encryption protocols.
     *
     * @return array
     */
    private function mailEncryptionProtocols()
    {
        return array_keys(trans('setting::settings.form.mail_encryption_protocols'));
    }


    /**
     * Get data to be validated from the request.
     *
     * @return array
     */
    public function validationData()
    {
        foreach ($this->shouldCheck as $attribute) {
            if (!$this->has($attribute)) {
                $this->merge([$attribute => null]);
            }
        }

        return $this->all();
    }
}
