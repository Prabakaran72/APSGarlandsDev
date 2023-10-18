<?php

namespace Modules\Blogpost\Entities;

use Modules\Admin\Ui\AdminTable;
use Modules\Support\Eloquent\Model;
use Modules\Meta\Eloquent\HasMetaData;
// use Modules\Support\Eloquent\Translatable;
use Modules\Blogcategory\Entities\Blogcategory;
use Modules\Blogpost\Entities\Blogpostlikesdislikes;
use Modules\Blogpost\Entities\Blogpostcomments;

use Modules\Blogtag\Entities\Blogtag;
use Modules\User\Entities\User;

class Blogpost extends Model
{
    use  HasMetaData;
    protected $table = 'blogposts';
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
    protected $fillable = ['post_title','post_body','post_status','tag_id','category_id','author_id','approved_date','approved_by','like','dislike'];

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
    protected $slugAttribute = 'post_name';

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
        return static::select('post_name')->firstOrNew(['id' => $id])->url();
    }
    public static function list()
    {
        return Cache::tags('blogtags')->rememberForever(md5('blogtags.list:' . locale()), function () {
            return self::all()->sortBy('tag_name')->pluck('tag_name', 'id');
        });
    }
    public function url()
    {
        if (is_null($this->slug)) {
            return '#';
        }

        return localized_url(locale(), $this->slug);
    }

    /**
     * Get table data for the resource
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function table()
    {
        return new AdminTable($this->with('category','tag','users')->newQuery()->withoutGlobalScope('active'));
    }
    public function category()
    {
        return $this->belongsTo(Blogcategory::class,'category_id');
    }
    public function tag()
    {
        return $this->belongsTo(Blogtag::class,'tag_id');
    }
    public function tags()
    {
        return $this->belongsToMany(Blogtag::class); // Assuming 'Tag' is your related model name
    }
    public function users()
    {
        return $this->belongsTo(User::class,'author_id');
    }
    public function likes(){

        return $this->hasMany(Blogpostlikesdislikes::class,'post_id')->sum('likes');
    }
    // Dislikes
    public function dislikes(){
        return $this->hasMany(Blogpostlikesdislikes::class,'post_id')->sum('dislikes');
    }
    public function blogcomments()
{
    return $this->hasMany(Blogpostcomments::class,'post_id');
}
}
