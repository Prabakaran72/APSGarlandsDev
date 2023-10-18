<?php

namespace Modules\Blogpost\Entities;
use Modules\Support\Eloquent\Model;
use Modules\Meta\Eloquent\HasMetaData;

class Blogpostlikesdislikes extends Model
{
    use  HasMetaData;
    protected $table = 'blogfeedback';
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
    protected $fillable = ['post_id','likes','dislikes','author_id'];

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

    /**
     * Perform any actions required after the model boots.
     *
     * @return void
     */





    /**
     * Get table data for the resource
     *
     * @return \Illuminate\Http\JsonResponse
     */

    public function users()
    {
        return $this->belongsTo(User::class,'author_id');
    }
}
