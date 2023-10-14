<?php

namespace Modules\Email\Entities;

use Modules\Admin\Ui\AdminTable;
use Modules\Support\Eloquent\Model;
use Modules\Meta\Eloquent\HasMetaData;
use Modules\Support\Eloquent\Sluggable;
use Modules\Support\Eloquent\Translatable;
use Modules\Subscriber\Entities\Subscriber;
class Email extends Model
{
    use  HasMetaData;

    /**
     * The relations to eager load on every query.
     *
     * @var array
     */
   

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */ 
    protected $fillable = ['subscribers','subject','template','template_id','date', 'is_active'];

    /**
     * The attributes that should be cast to native types.
     *
     * @var array
     */
    protected $casts = [
        'is_active' => 'boolean',
    ];

    /**
     * The attributes that are translatable.
     *
     * @var array
     */
   

    

    /**
     * Perform any actions required after the model boots.
     *
     * @return void
     */
    // protected static function booted()
    // {
    //     static::addActiveGlobalScope();
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

    public function subscriber()
    {
        return $this->belongsTo(Subscriber::class,'email','subscribers');   
    }
    
}
