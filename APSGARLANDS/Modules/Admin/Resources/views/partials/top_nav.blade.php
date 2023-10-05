<nav class="navbar navbar-static-top clearfix">
    <ul class="nav navbar-nav clearfix">
        <li class="visit-store hidden-sm hidden-xs">
            <a href="{{ route('home') }}">
                <i class="fa fa-desktop"></i>
                {{ trans('admin::admin.visit_store') }}
            </a>
        </li>

        <li class="dropdown top-nav-menu pull-right">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
            @switch(true)
                  @case($currentUser->sso_google == '1' || $currentUser->sso_fb == '1')
                          <img src="{{ auth()->user()->sso_avatar }}" alt="User Profile Image" class="profile-image">
                  @break

                  @case($currentUser->sso_fb == '' && $currentUser->sso_google == '' && (!empty($currentUser->image_url)))
                          <img src="{{ auth()->user()->image_url }}" alt="User Profile Image" class="profile-image">
                  @break

                  @default
                          <i class="las la-user"></i>
                  @endswitch<span>{{ $currentUser->first_name }}</span>
            </a>

            <ul class="dropdown-menu">
                <li><a href="{{ route('admin.profile.edit') }}">{{ trans('user::users.profile') }}</a></li>
                <li><a href="{{ route('admin.logout') }}">{{ trans('user::auth.logout') }}</a></li>
            </ul>
        </li>

        @if (count(supported_locales()) > 1)
            <li class="language dropdown top-nav-menu pull-right">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                    <span>{{ strtoupper(locale()) }}</span>
                </a>

                <ul class="dropdown-menu">
                    @foreach (supported_locales() as $locale => $language)
                        <li class="{{ $locale === locale() ? 'active' : '' }}">
                            <a href="{{ localized_url($locale) }}">{{ $language['name'] }}</a>
                        </li>
                    @endforeach
                </ul>
            </li>
        @endif
    </ul>
</nav>
<style>
.profile-image {
    width: 30px; /* Adjust the width and height as needed */
    height: 30px;
    border-radius: 50%; /* Creates a circular shape */
    border: 2px solid #fff; /* Optional border style */
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2); /* Optional shadow effect */
    object-fit: cover; /* Ensures the image covers the container */
}
</style>