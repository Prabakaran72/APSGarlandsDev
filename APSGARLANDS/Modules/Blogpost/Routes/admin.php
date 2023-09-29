<?php

use Illuminate\Support\Facades\Route;

Route::get('blogposts', [
    'as' => 'admin.blogposts.index',
    'uses' => 'BlogpostController@index',
    'middleware' => 'can:admin.blogposts.index',
]);

Route::get('blogposts/create', [
    'as' => 'admin.blogposts.create',
    'uses' => 'BlogpostController@create',
    'middleware' => 'can:admin.blogposts.create',
]);

Route::post('blogposts', [
    'as' => 'admin.blogposts.store',
    'uses' => 'BlogpostController@store',
    'middleware' => 'can:admin.blogposts.create',
]);

Route::get('blogposts/{id}/edit', [
    'as' => 'admin.blogposts.edit',
    'uses' => 'BlogpostController@edit',
    'middleware' => 'can:admin.blogposts.edit',
]);

Route::put('blogposts/{id}/edit', [
    'as' => 'admin.blogposts.update',
    'uses' => 'BlogpostController@update',
    'middleware' => 'can:admin.blogposts.edit',
]);

Route::delete('blogposts/{ids?}', [
    'as' => 'admin.blogposts.destroy',
    'uses' => 'BlogpostController@destroy',
    'middleware' => 'can:admin.blogposts.destroy',
]);
