<?php

use Illuminate\Support\Facades\Route;

Route::get('rewardpoints', [
    'as' => 'admin.rewardpoints.edit',
    'uses' => 'RewardpointsController@edit',
    'middleware' => 'can:admin.rewardpoints.edit',
]);


Route::put('rewardpoints', [
    'as' => 'admin.rewardpoints.update',
    'uses' => 'RewardpointsController@update',
    'middleware' => 'can:admin.rewardpoints.edit',
]);

