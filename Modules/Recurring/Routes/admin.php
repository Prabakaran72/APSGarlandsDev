<?php

use Illuminate\Support\Facades\Route;

Route::get('recurrings', [
    'as' => 'admin.recurrings.index',
    'uses' => 'RecurringController@index',
    'middleware' => 'can:admin.recurrings.index',
]);

Route::get('recurringSubOrder/{id?}', [
    'as' => 'admin.recurringSubOrder.index',
    'uses' => 'RecurringSubOrderController@index',
    'middleware' => 'can:admin.recurringSubOrder.index',
]);

Route::get('recurrings/create', [
    'as' => 'admin.recurrings.create',
    'uses' => 'RecurringController@create',
    'middleware' => 'can:admin.recurrings.create',
]);

Route::get('recurringSubOrder/{id}/edit', [
    'as' => 'admin.recurrings.edit',
    'uses' => 'RecurringSubOrderController@edit',
    'middleware' => 'can:admin.recurringSubOrder.index',
]);

Route::delete('recurrings/{ids?}', [
    'as' => 'admin.recurrings.destroy',
    'uses' => 'recurringController@destroy',
    'middleware' => 'can:admin.recurrings.destroy',
]);

Route::post('admin/recurrings/unsubscribeMultipleOrder', 'RecurringSubOrderController@unsubscribeMultipleOrder')->name('admin.recurrings.unsubscribeMultipleOrder');
