<?php

use Illuminate\Support\Facades\Route;

Route::get('/', 'HomeController@index')->name('home');
Route::get('getpincode', 'FixedrateController@getpincode')->name('Fixedrate.getpincode');
Route::get('getfixedrates', 'FixedrateController@getfixedrates')->name('Fixedrate.getfixedrates');

// Route::get('getpincode',[
//     'as' => 'admin.fixedrates.getpincode',
//     'uses'=>'FixedrateController@getPincode',
//     'middleware' => 'can:admin.fixedrates.index',
//     ] ); // You can specify a name for the route if needed
// Route::get('getfixedrates',[
//      'as' => 'admin.fixedrates.getfixedrates',
//      'uses'=>'FixedrateController@getFixedrates',
//      'middleware' => 'can:admin.fixedrates.index',
//      ]); 
