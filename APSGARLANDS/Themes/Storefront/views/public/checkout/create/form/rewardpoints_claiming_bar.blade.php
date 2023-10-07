
@if (setting('rewardpoints_enabled') )
    <rewardpoints-claiming inline-template>
        <div class="cookie-bar-wrap" :class="{ show: show }">
            <div class="container d-flex justify-content-center">
                <div class="col-xl-10 col-lg-12">
                    <div class="row justify-content-center">
                        <div class="cookie-bar">
                            <div class="cookie-bar-text">
                                {!! trans('storefront::layout.the_website_uses_cookies') !!}
                            </div>

                            <div class="cookie-bar-action">
                                <button class="btn btn-primary btn-accept" @click="accept">
                                    {{ 'Rewardpoints checkout page' }}
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </rewardpoints-claiming>
@endif
