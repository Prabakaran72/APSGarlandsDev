<?php

namespace Modules\User\Entities;

use Modules\Order\Entities\Order;
use Modules\User\Admin\UserTable;
use Modules\Review\Entities\Review;
use Modules\Testimonial\Entities\Testimonial;
use Illuminate\Auth\Authenticatable;
use Modules\Address\Entities\Address;
use Modules\Product\Entities\Product;
use Modules\User\Repositories\Permission;
use Cartalyst\Sentinel\Users\EloquentUser;
use Modules\Address\Entities\DefaultAddress;
use Cartalyst\Sentinel\Laravel\Facades\Activation;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;
use Illuminate\Contracts\Auth\Authenticatable as AuthenticatableContract;
use Modules\RewardpointsGift\Entities\RewardpointsGift;
use Modules\RewardpointsGift\Entities\CustomerRewardPoint;
use Modules\Rewardpoints\Entities\Rewardpoints;
use Illuminate\Support\Facades\DB;

class User extends EloquentUser implements AuthenticatableContract
{
    use Authenticatable;

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'email',
        'phone',
        'password',
        'last_name',
        'first_name',
        'permissions',
        'sso_id',
        'sso_username',
        'sso_locale',
        'sso_avatar',
        'is_sso_google',
        'is_sso_fb',
        'image_url'
    ];

    /**
     * The attributes that should be mutated to dates.
     *
     * @var array
     */
    protected $dates = ['last_login'];

    public static function registered($email)
    {
        return static::where('email', $email)->exists();
    }

    public static function findByEmail($email)
    {
        return static::where('email', $email)->first();
    }

    public static function totalCustomers()
    {
        return Role::findOrNew(setting('customer_role'))->users()->count();
    }

    /**
     * Login the user.
     *
     * @return $this|bool
     */
    public function login()
    {
        return auth()->login($this);
    }

    /**
     * Determine if the user is a customer.
     *
     * @return bool
     */
    public function isCustomer()
    {
        if ($this->hasRoleName('admin')) {
            return false;
        }

        return $this->hasRoleId(setting('customer_role'));
    }

    /**
     * Checks if a user belongs to the given Role ID.
     *
     * @param int $roleId
     * @return bool
     */
    public function hasRoleId($roleId)
    {
        return $this->roles()->whereId($roleId)->count() !== 0;
    }

    /**
     * Checks if a user belongs to the given Role Name.
     *
     * @param string $name
     * @return bool
     */
    public function hasRoleName($name)
    {
        return $this->roles()->whereTranslation('name', $name)->count() !== 0;
    }

    /**
     * Check if the current user is activated.
     *
     * @return bool
     */
    public function isActivated()
    {
        return Activation::completed($this);
    }

    /**
     * Get the recent orders of the user.
     *
     * @param int $take
     * @return \Illuminate\Database\Eloquent\Collection
     */
    public function recentOrders($take)
    {
        return $this->orders()->latest()->take($take)->get();
    }

    /**
     * Get the roles of the user.
     *
     * @return \Illuminate\Database\Eloquent\Relations\BelongsToMany
     */
    public function roles(): BelongsToMany
    {
        return $this->belongsToMany(Role::class, 'user_roles')->withTimestamps();
    }

    /**
     * Get the orders of the user.
     *
     * @return \Illuminate\Database\Eloquent\Relations\HasMany
     */
    public function orders()
    {
        return $this->hasMany(Order::class, 'customer_id');
    }

    /**
     * Get the wishlist of the user.
     *
     * @return \Illuminate\Database\Eloquent\Relations\BelongsToMany
     */

    public function wishlist()
    {
        // return $this->belongsToMany(Product::class, 'wish_lists')->withTimestamps();
        return $this->belongsToMany(Product::class, 'wish_lists')->where('is_deleted', 0)->withTimestamps();
    }

    /**
     * Get the default address of the user.
     *
     * @return \Illuminate\Database\Eloquent\Relations\HasMany
     */
    public function defaultAddress()
    {
        return $this->hasOne(DefaultAddress::class, 'customer_id')->withDefault();
    }

    /**
     * Get the addresses of the user.
     *
     * @return \Illuminate\Database\Eloquent\Relations\HasMany
     */
    public function addresses()
    {
        return $this->hasMany(Address::class, 'customer_id');
    }

    /**
     * Get the reviews of the user.
     *
     * @return \Illuminate\Database\Eloquent\Relations\HasMany
     */
    public function reviews()
    {
        return $this->hasMany(Review::class, 'reviewer_id');
    }

    public function testimonials()
    {
        return $this->hasMany(Testimonial::class, 'user_id');
    }

    /**
     * Get the full name of the user.
     *
     * @return string
     */
    // public function getFullNameAttribute()
    // {
    //     return "{$this->first_name} {$this->last_name}";
    // }
    public function getFullNameAttribute()
    {
        // return ucfirst($this->customer_first_name)." ".ucfirst($this->customer_last_name);
        return ucfirst($this->first_name) . " " . ucfirst($this->last_name);
    }


    /**
     * Set user's permissions.
     *
     * @param array $permissions
     * @return void
     */
    public function setPermissionsAttribute(array $permissions)
    {
        $this->attributes['permissions'] = Permission::prepare($permissions);
    }

    /**
     * Determine if the user has access to the given permissions.
     *
     * @param array|string $permissions
     * @return bool
     */
    public function hasAccess($permissions)
    {
        $permissions = is_array($permissions) ? $permissions : func_get_args();

        return $this->getPermissionsInstance()->hasAccess($permissions);
    }

    /**
     * Determine if the user has access to the any given permissions
     *
     * @param array|string $permissions
     * @return bool
     */
    public function hasAnyAccess($permissions)
    {
        $permissions = is_array($permissions) ? $permissions : func_get_args();

        return $this->getPermissionsInstance()->hasAnyAccess($permissions);
    }

    public function wishlistHas($productId)
    {
        return self::wishlist()->where('product_id', $productId)->exists();
    }

    /**
     * Get table data for the resource
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function table()
    {
        return new UserTable($this->newQuery());
    }

    public function rewardpointsgift()
    {
        return $this->hasMany(RewardpointsGift::class, 'user_id');
    }

    public function customerRewardPoints()
    {
        return $this->hasMany(CustomerRewardPoint::class, 'customer_id');
    }

    public function customerlist()
    {
        $customerUsers = User::where(function ($query) {
            $query->hasRoleName('customer');
        })->get();
    }

    public function getUsersActiveRewardpoints()
    {
        $userRewardsLog =  CustomerRewardPoint::where('customer_id', auth()->user()->id)
            ->selectRaw('SUM(reward_points_earned) as reward_points_earned_total')
            ->selectRaw('SUM(reward_points_claimed) as  reward_points_claimed_total')
            ->selectRaw('SUM(CASE WHEN expiry_date IS NOT NULL AND expiry_date < NOW() THEN reward_points_earned ELSE 0 END) as expired_points')
            ->get();

        if (!empty($userRewardsLog->reward_points_earned_total)) {
            $usersActiveRewardpoints = $userRewardsLog->reward_points_earned_total - ($userRewardsLog->reward_points_claimed_total ?? $userRewardsLog->reward_points_claimed_total) - ($userRewardsLog->expired_points ?? $userRewardsLog->expired_points);
        }
        else{
            $usersActiveRewardpoints = 0;
        }

        $rewardSetting = Rewardpoints::first();

        return (['rewardSetting'=>$rewardSetting, 'userRewardsLog'=>$userRewardsLog, 'usersActiveRewardpoints'=> $usersActiveRewardpoints]);
    }
}
