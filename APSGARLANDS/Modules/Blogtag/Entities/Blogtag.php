<?php

namespace Modules\Blogtag\Entities;

use Modules\Admin\Ui\AdminTable;
use Modules\Support\Eloquent\Model;
use Modules\Meta\Eloquent\HasMetaData;
// use Modules\Support\Eloquent\Translatable;
use Illuminate\Support\Facades\Cache;

class Blogtag extends Model
{
    use  HasMetaData;
    protected $table = 'blogtags';
    /**
     * The relations to eager load on every query.
     *
     * @var array
     */
    // protected $with = ['translations'];

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = ['tag_name','tag_code','description'];

    /**
     * The attributes that should be cast to native types.
     *
     * @var array
     */
    // protected $casts = [
    //     'is_active' => 'boolean',
    // ];

    /**
     * The attributes that are translatable.
     *
     * @var array
     */
    protected $translatedAttributes = ['name'];

    /**
     * The attribute that will be slugged.
     *
     * @var string
     */
    protected $slugAttribute = 'tag_name';

    /**
     * Perform any actions required after the model boots.
     *
     * @return void
     */
    protected static function booted()
    {
        static::addActiveGlobalScope();
    }

    public static function urlForPage($id)
    {
        return static::select('tag_name')->firstOrNew(['id' => $id])->url();
    }

    public function url()
    {
        if (is_null($this->slug)) {
            return '#';
        }

        return localized_url(locale(), $this->slug);
    }
    public static function list()
    {
        return Cache::remember('blogtags.list:' . locale(), 60, function () {
            return self::all()->sortBy('id')->pluck('tag_name', 'id');
        });

    }
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
