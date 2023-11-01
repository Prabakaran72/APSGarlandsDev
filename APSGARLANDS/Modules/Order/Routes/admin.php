<?php

use Illuminate\Support\Facades\Route;

Route::get('orders', [
    'as' => 'admin.orders.index',
    'uses' => 'OrderController@index',
    'middleware' => 'can:admin.orders.index',
]);

Route::get('orders/create', [
    'as' => 'admin.orders.create',
    'uses' => 'OrderController@create',
    'middleware' => 'can:admin.orders.create',
]);

Route::get('orders/{id}', [
    'as' => 'admin.orders.show',
    'uses' => 'OrderController@show',
    'middleware' => 'can:admin.orders.show',
]);

Route::put('orders/{order}/status', [
    'as' => 'admin.orders.status.update',
    'uses' => 'OrderStatusController@update',
    'middleware' => 'can:admin.orders.edit',
]);

Route::post('orders/{order}/email', [
    'as' => 'admin.orders.email.store',
    'uses' => 'OrderEmailController@store',
    'middleware' => 'can:admin.orders.show',
]);

Route::get('orders/{order}/print', [
    'as' => 'admin.orders.print.show',
    'uses' => 'OrderPrintController@show',
    'middleware' => 'can:admin.orders.show',
]);
// update_shipping_address
Route::post('orders/{id}/updateshipping',[
    'as' => 'admin.order.updateshipping',
    'uses' => 'OrderController@updateshipping',
    'middleware' => 'can:admin.orders.edit',
]);

Route::get('orders/{id}/details', [
    'as' => 'admin.orders.print.details',
    'uses' => 'OrderController@details',
]);

Route::post('orders', [
    'as' => 'admin.orders.store',
    'uses' => 'OrderController@store',
    
]);

Route::put('orders/{id}/edit', [
    'as' => 'admin.orders.update',
    'uses' => 'OrderController@update',
    'middleware' => 'can:admin.orders.edit',
]);

Route::delete('orders/{ids?}', [
    'as' => 'admin.orders.destroy',
    'uses' => 'OrderController@destroy',
    'middleware' => 'can:admin.orders.destroy',
]);

Route::get('orders/coupontest', [
    'as' => 'admin.orders.coupontest',
    'uses' => 'OrderController@coupontest',
]);


//  'OrderController@updateShipping')->name('update_shipping');
