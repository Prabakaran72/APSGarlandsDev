<?php

use Illuminate\Support\Facades\Route;

Route::get('/', 'HomeController@index')->name('home');
Route::get('getLocalPickupAddress', 'PickupstoreController@getLocalPickupAddress')->name('Pickupstore.getLocalPickupAddress');
// Route::get('getLocalPickupAddress',[
//     'as' => 'admin.pickupstores.getLocalPickupAddress',
//     'uses'=>'PickupstoreController@getLocalPickupAddress',
//     'middleware' => 'can:admin.pickupstores.index',
// ]);
