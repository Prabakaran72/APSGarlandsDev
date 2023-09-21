<?php

use Illuminate\Support\Facades\Route;

Route::get('recurrings', [
    'as' => 'admin.recurrings.index',
    'uses' => 'RecurringController@index',
    'middleware' => 'can:admin.recurrings.index',
]);

Route::get('recurrings/create', [
    'as' => 'admin.recurrings.create',
    'uses' => 'RecurringController@create',
    'middleware' => 'can:admin.recurrings.create',
]);

Route::post('recurrings', [
    'as' => 'admin.recurrings.store',
    'uses' => 'RecurringController@store',
    'middleware' => 'can:admin.recurrings.create',
]);

Route::get('recurrings/{id}/edit', [
    'as' => 'admin.recurrings.edit',
    'uses' => 'RecurringOrderController@edit',
]);

Route::put('recurrings/{id}', [
    'as' => 'admin.recurrings.update',
    'uses' => 'RecurringController@update',
    'middleware' => 'can:admin.recurrings.edit',
]);

Route::delete('recurrings/{ids?}', [
    'as' => 'admin.recurrings.destroy',
    'uses' => 'RecurringController@destroy',
    'middleware' => 'can:admin.recurrings.destroy',
]);
