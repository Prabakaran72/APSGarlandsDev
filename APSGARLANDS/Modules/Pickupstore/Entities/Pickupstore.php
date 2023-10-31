<?php

namespace Modules\Pickupstore\Entities;

use Modules\Admin\Ui\AdminTable;
use Modules\Support\Eloquent\Model;
use Modules\Support\State;
use Modules\Support\Country;




class Pickupstore extends Model
{
    //use Translatable, Sluggable, HasMetaData;

    /**
     * The relations to eager load on every query.
     *
     * @var array
     */
    //protected $with = ['translations'];

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = ['first_name','tagline','email', 'phone', 'address_1', 'address_2', 'city', 'state','country', 'zip', 'is_active'];
    /** 
     * The attributes that should be cast to native types.
     *
     * @var array
     */
    public function getStateNameAttribute()
    { 
       // dd(State::name($this->country, $this->state));
        return State::name($this->country, $this->state);
    }
    public function getCountryNameAttribute()
    {
        return Country::name($this->country);
    }

    protected $casts = [
        'is_active' => 'boolean',
    ];

    /**
     * The attributes that are translatable.
     *
     * @var array
     */
    //protected $translatedAttributes = ['name', 'body'];

    /**
     * The attribute that will be slugged.
     *
     * @var string
     */
    //protected $slugAttribute = 'name';

    /**
     * Perform any actions required after the model boots.
     *
     * @return void
     */
    protected static function booted()
    {
        static::addActiveGlobalScope();
    }

    // public static function urlForPickupstore($id)
    // {
    //     return static::select('slug')->firstOrNew(['id' => $id])->url();
    // }

    // public function url()
    // {
    //     if (is_null($this->slug)) {
    //         return '#';
    //     }

    //     return localized_url(locale(), $this->slug);
    // }

    /**
     * Get table data for the resource
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function table()
    {
        return new AdminTable($this->newQuery()->withoutGlobalScope('active'));
    }
}
