<?php

use Illuminate\Support\Facades\Route;

Route::get('blogcategorys', [
    'as' => 'admin.blogcategorys.index',
    'uses' => 'BlogcategoryController@index',
    'middleware' => 'can:admin.blogcategorys.index',
]);

Route::get('blogcategorys/create', [
    'as' => 'admin.blogcategorys.create',
    'uses' => 'BlogcategoryController@create',
    'middleware' => 'can:admin.blogcategorys.create',
]);

Route::post('blogcategorys', [
    'as' => 'admin.blogcategorys.store',
    'uses' => 'BlogcategoryController@store',
    'middleware' => 'can:admin.blogcategorys.create',
]);

Route::get('blogcategorys/{id}/edit', [
    'as' => 'admin.blogcategorys.edit',
    'uses' => 'BlogcategoryController@edit',
    'middleware' => 'can:admin.blogcategorys.edit',
]);

Route::put('blogcategorys/{id}/edit', [
    'as' => 'admin.blogcategorys.update',
    'uses' => 'BlogcategoryController@update',
    'middleware' => 'can:admin.blogcategorys.edit',
]);

Route::delete('blogcategorys/{ids?}', [
    'as' => 'admin.blogcategorys.destroy',
    'uses' => 'BlogcategoryController@destroy',
    'middleware' => 'can:admin.blogcategorys.destroy',
]);
