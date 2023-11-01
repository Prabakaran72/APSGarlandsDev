<?php

use Illuminate\Support\Facades\Route;

Route::get('subscribers', [
    'as' => 'admin.subscribers.index',
    'uses' => 'SubscriberController@index',
    'middleware' => 'can:admin.subscribers.index',
]);

Route::get('subscribers/create', [
    'as' => 'admin.subscribers.create',
    'uses' => 'SubscriberController@create',
    'middleware' => 'can:admin.subscribers.create',
]);

Route::post('subscribers', [
    'as' => 'admin.subscribers.store',
    'uses' => 'SubscriberController@store',
    'middleware' => 'can:admin.subscribers.create',
]);

Route::get('subscribers/{id}/edit', [
    'as' => 'admin.subscribers.edit',
    'uses' => 'SubscriberController@edit',
    'middleware' => 'can:admin.subscribers.edit',
]);

Route::put('subscribers/{id}/edit', [
    'as' => 'admin.subscribers.update',
    'uses' => 'SubscriberController@update',
    'middleware' => 'can:admin.subscribers.edit',
]);

Route::delete('subscribers/{ids?}', [
    'as' => 'admin.subscribers.destroy',
    'uses' => 'SubscriberController@destroy',
    'middleware' => 'can:admin.subscribers.destroy',
]);
