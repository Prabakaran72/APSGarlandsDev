<?php

use Illuminate\Support\Facades\Route;

Route::get('galleries', [
    'as' => 'admin.galleries.index',
    'uses' => 'GalleriesController@index',
    'middleware' => 'can:admin.galleries.index',
]);

Route::post('galleries', [
    'as' => 'admin.galleries.store',
    'uses' => 'GalleriesController@store',
    'middleware' => 'can:admin.galleries.create',
]);

Route::delete('galleries/{ids?}', [
    'as' => 'admin.galleries.destroy',
    'uses' => 'GalleriesController@destroy',
    'middleware' => 'can:admin.galleries.destroy',
]);

Route::get('file-manager', [
    'uses' => 'FileManagerController@index',
    'as' => 'admin.file_manager.index',
    'middleware' => 'can:admin.galleries.index',
]);
