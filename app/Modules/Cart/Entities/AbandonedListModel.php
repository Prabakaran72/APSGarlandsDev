<?php

namespace FleetCart\Modules\Cart\Entities;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
class AbandonedListModel extends Model
{
    use HasFactory;
    Protected $table='abandonedcartlistreport';
    protected $fillable = ['slug', 'customer_id','quantity','rate'];

}
