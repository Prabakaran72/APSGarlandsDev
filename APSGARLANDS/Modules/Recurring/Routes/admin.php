<?php

use Illuminate\Support\Facades\Route;

//LIST THE ALL RECURRING ORDER DETAILS
Route::get('recurrings', [
    'as' => 'admin.recurrings.index',
    'uses' => 'RecurringController@index',
    'middleware' => 'can:admin.recurrings.index',
]);

//LIST THE INDIVIDUAL RECURRING ORDER DETAILS
Route::get('recurringSubOrder/{id}/edit', [
    'as' => 'admin.recurrings.edit',
    'uses' => 'RecurringSubOrderController@edit',
    'middleware' => 'can:admin.recurrings.edit',
]);

// Route::put('recurringSubOrder/{id}/update', [
//     'as' => 'admin.recurrings.update',
//     'uses' => 'RecurringSubOrderController@update',
//     'middleware' => 'can:admin.recurrings.edit',
// ]);

// VIEW RECURRING ORDER DETAILS FROM ORDER PAGE
Route::get('orderToRecurring/{id}', [
    'as' => 'admin.recurring.mainorder.edit',
    'uses' => 'RecurringSubOrderController@orderToRecurringRedirection',
    'middleware' => 'can:admin.recurrings.edit',
]);

//UPDATE THE SUBSCRIBE TO UNSUBSCRIBE
Route::post('admin/recurrings/unsubscribeMultipleOrder', 'RecurringSubOrderController@unsubscribeMultipleOrder')->name('admin.recurrings.unsubscribeMultipleOrder');

//UPDATE ORDER STATUS
Route::post('admin/recurrings/updateOrderStatus', 'RecurringSubOrderController@updateOrderStatus')->name('admin.recurrings.updateOrderStatus');
