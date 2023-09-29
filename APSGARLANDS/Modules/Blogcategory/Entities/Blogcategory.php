<?php

namespace Modules\Blogcategory\Entities;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Modules\Admin\Ui\AdminTable;
use Modules\Support\Eloquent\Model;
use Modules\Meta\Eloquent\HasMetaData;
use Modules\Blogpost\Entities\Blogpost;
use Illuminate\Support\Facades\Cache;

class Blogcategory extends Model
{
    use  HasMetaData,HasFactory;
    protected $table = 'blogcategorys';
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
    protected $fillable = ['category_name','category_code','description'];

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
    protected $slugAttribute = 'category_name';

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
        return static::select('category_name')->firstOrNew(['id' => $id])->url();
    }

    public function url()
    {
        if (is_null($this->slug)) {
            return '#';
        }

        return localized_url(locale(), $this->slug);
    }
    // public function blogpost()
    // {
    //     return $this->hasMany(Blogpost::class);
    // }
    // public static function treeList()
    // {
    //     return Cache::tags('blogcategorys')->rememberForever(md5('blogcategorys.tree_list:' . locale()), function () {
    //         return static::orderByRaw('-position DESC')
    //             ->get()
    //             ->nest()
    //             ->setIndent('¦–– ')
    //             ->listsFlattened('category_name');
    //     });
    // }
    public static function list()
    {
        return Cache::remember('blogcategorys.list:' . locale(), 60, function () {
            return self::all()->sortBy('id')->pluck('category_name', 'id');
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
