<?php

use Illuminate\Support\Facades\Route;

Route::get('rewardpointsgift', [
    'as' => 'admin.rewardpointsgift.index',
    'uses' => 'RewardpointGiftController@index',
    'middleware' => 'can:admin.rewardpointsgift.index',
]);

Route::get('rewardpointsgift/create/{id}', [
    'as' => 'admin.rewardpointsgift.create',
    'uses' => 'RewardpointGiftController@create',
    'middleware' => 'can:admin.rewardpointsgift.create',
]);

Route::post('rewardpointsgift', [
    'as' => 'admin.rewardpointsgift.store',
    'uses' => 'RewardpointGiftController@store',
    'middleware' => 'can:admin.rewardpointsgift.create',
]);

Route::get('rewardpointsgift/{id}', [
    'as' => 'admin.rewardpointsgift.edit',
    'uses' => 'RewardpointGiftController@show',
    'middleware' => 'can:admin.rewardpointsgift.edit',
]);
Route::get('rewardpointsgift/customer/{id}', [
    'as' => 'admin.rewardpointsgift.customer',
    'uses' => 'RewardpointGiftController@edit',
    'middleware' => 'can:admin.rewardpointsgift.edit',
]);

Route::put('rewardpointsgift/{id}', [
    'as' => 'admin.rewardpointsgift.update',
    'uses' => 'RewardpointGiftController@update',
    'middleware' => 'can:admin.rewardpointsgift.edit',
]);

Route::delete('rewardpointsgift/{ids?}', [
    'as' => 'admin.rewardpointsgift.destroy',
    'uses' => 'RewardpointGiftController@destroy',
    'middleware' => 'can:admin.rewardpointsgift.destroy',
]);

// Customer Rewardpoints Controller
//Route used to handle the rewardpoints by the admin
Route::get('customerrewardpoints', [
    'as' => 'admin.customerrewardpoints.index',
    'uses' => 'CustomerRewardpointController@index',
    'middleware' => 'can:admin.customerrewardpoints.index',
]);

Route::get('customerrewardpoints/create', [
    'as' => 'admin.customerrewardpoints.create',
    'uses' => 'CustomerRewardpointController@create',
    'middleware' => 'can:admin.customerrewardpoints.create',
]);

Route::post('customerrewardpoints', [
    'as' => 'admin.customerrewardpoints.store',
    'uses' => 'CustomerRewardpointController@store',
    'middleware' => 'can:admin.customerrewardpoints.create',
]);

Route::get('customerrewardpoints/{id}', [
    'as' => 'admin.customerrewardpoints.edit',
    'uses' => 'CustomerRewardpointController@show',
    'middleware' => 'can:admin.customerrewardpoints.edit',
]);

Route::put('customerrewardpoints/{id}', [
    'as' => 'admin.customerrewardpoints.update',
    'uses' => 'CustomerRewardpointController@update',
    'middleware' => 'can:admin.customerrewardpoints.edit',
]);

Route::delete('customerrewardpoints/{ids?}', [
    'as' => 'admin.customerrewardpoints.destroy',
    'uses' => 'CustomerRewardpointController@destroy',
    'middleware' => 'can:admin.customerrewardpoints.destroy',
]);

