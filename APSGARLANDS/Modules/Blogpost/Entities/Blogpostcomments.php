<?php

namespace Modules\Blogpost\Entities;
use Modules\Support\Eloquent\Model;
use Modules\Meta\Eloquent\HasMetaData;
use Modules\User\Entities\User;

class Blogpostcomments extends Model
{
    use  HasMetaData;
    protected $table = 'blogcomment';
    
    protected $fillable = ['post_id','comments','is_active','author_id'];

    protected $translatedAttributes = ['name'];

    public function post()
    {
        return $this->belongsTo(Blogpost::class,'post_id');
    }
    public function users()
    {
        return $this->belongsTo(User::class,'author_id');
    }
}
