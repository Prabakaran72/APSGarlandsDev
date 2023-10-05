<?php

namespace Modules\User\Http\Controllers;

use Exception;
use Modules\Page\Entities\Page;
use Modules\User\Entities\User;
use Modules\User\LoginProvider;
use Illuminate\Support\Facades\Cache;
use Laravel\Socialite\Facades\Socialite;

class AuthController extends BaseAuthController
{
    /**
     * Where to redirect users after login..
     *
     * @return string
     */
    protected function redirectTo()
    {
        return route('account.dashboard.index');
    }

    /**
     * The login URL.
     *
     * @return string
     */
    protected function loginUrl()
    {
        return route('login');
    }

    /**
     * Show login form.
     *
     * @return \Illuminate\Http\Response
     */
    public function getLogin()
    {
        return view('public.auth.login', [
            'providers' => LoginProvider::enabled(),
        ]);
    }

    /**
     * Redirect the user to the given provider authentication page.
     *
     * @param string $provider
     * @return \Illuminate\Http\Response
     */
    public function redirectToProvider($provider)
    {
        if (! LoginProvider::isEnable($provider)) {
            abort(404);
        }

        return Socialite::driver($provider)->redirect();
    }

    /**
     * Obtain the user information from the given provider.
     *
     * @param string $provider
     * @return \Illuminate\Http\Response
     */
    public function handleProviderCallback($provider)
    {
        if (! LoginProvider::isEnable($provider)) {
            abort(404);
        }

        try {
            $user = Socialite::driver($provider)->user();
        } catch (Exception $e) {
            return redirect()->route('login')->with('error', $e->getMessage());
        }

        if (User::registered($user->getEmail())) {
            auth()->login(
                User::findByEmail($user->getEmail())
            );

            return redirect($this->redirectTo());
        }

        $is_sso_google   =   $is_sso_fb  =   0;

        if (!(empty($user->user['sub']))) {
            $is_sso_google  =   '1';
            $is_sso_fb  =   '0';
        } else {
            $is_sso_fb  =   '1';
            $is_sso_google  =   '0';
        }

        echo "\r\n <br/> user : \r\n <br/><pre>"; print_r($user);
        exit();
        $googleID   =   $googleLocale   =   $googleAvatar   =   '';

        if(!(empty($user))) {
            //foreach($user as $gData) {
            $googleID   =   $user->user['sub'];
            $googleLocale   =   $user->user['locale'];
            $googleAvatar   =   $user->avatar;
        }

        [$firstName, $lastName] =   $this->extractName($user->getName());

        $registeredUser =   $this->auth->registerAndActivate([
            'first_name' => $firstName,
            'last_name' => $lastName,
            'email' => $user->getEmail(),
            'phone' => '',
            'is_sso_google' => $is_sso_google,
            'is_sso_fb' => $is_sso_fb,
            'password' => str_random(),
            'google_id' =>  $googleID,
            'google_username'   =>  $user->getName(),
            'google_locale' =>  $googleLocale,
            'google_avatar' =>  $googleAvatar,
        ]);

        $this->assignCustomerRole($registeredUser);
        auth()->login($registeredUser);
        return redirect($this->redirectTo());
    }

    private function extractName($name)
    {
        return explode(' ', $name, 2);
    }

    /**
     * Show registrations form.
     *
     * @return \Illuminate\Http\Response
     */
    public function getRegister()
    {
        return view('public.auth.register', [
            'privacyPageUrl' => $this->getPrivacyPageUrl(),
            'providers' => LoginProvider::enabled(),
        ]);
    }

    /**
     * Get privacy page url.
     *
     * @return string
     */
    private function getPrivacyPageUrl()
    {
        return Cache::tags('settings')->rememberForever('privacy_page_url', function () {
            return Page::urlForPage(setting('storefront_privacy_page'));
        });
    }

    /**
     * Show reset password form.
     *
     * @return \Illuminate\Http\Response
     */
    public function getReset()
    {
        return view('public.auth.reset.begin');
    }

    /**
     * Reset complete form route.
     *
     * @param \Modules\User\Entities\User $user
     * @param string $code
     * @return string
     */
    protected function resetCompleteRoute($user, $code)
    {
        return route('reset.complete', [$user->email, $code]);
    }

    /**
     * Password reset complete view.
     *
     * @return string
     */
    protected function resetCompleteView()
    {
        return view('public.auth.reset.complete');
    }
}
