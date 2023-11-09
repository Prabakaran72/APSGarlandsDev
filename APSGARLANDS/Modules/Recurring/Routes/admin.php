<?php

use Illuminate\Support\Facades\Route;

Route::get('recurrings', [
    'as' => 'admin.recurrings.index',
    'uses' => 'RecurringController@index',
    'middleware' => 'can:admin.recurrings.index',
]);


Route::get('recurringSubOrder/{id}/edit', [
    'as' => 'admin.recurrings.edit',
    'uses' => 'RecurringSubOrderController@edit',
    'middleware' => 'can:admin.recurrings.edit',
]);

Route::get('orderToRecurring/{id}', [
    'as' => 'admin.recurring.mainorder.edit',
    'uses' => 'RecurringSubOrderController@orderToRecurringRedirection',
    'middleware' => 'can:admin.recurrings.edit',
]);

// Route::delete('recurrings/{ids?}', [
//     'as' => 'admin.recurrings.destroy',
//     'uses' => 'recurringController@destroy',
//     'middleware' => 'can:admin.recurrings.destroy',
// ]);

Route::post('admin/recurrings/unsubscribeMultipleOrder', 'RecurringSubOrderController@unsubscribeMultipleOrder')->name('admin.recurrings.unsubscribeMultipleOrder');
