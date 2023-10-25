<?php

use Illuminate\Support\Facades\Route;

Route::post('cart/rewardpoints', 'RewardpointsController@store')->name('cart.rewardpoints.store');
Route::delete('cart/rewardpoints', 'RewardpointsController@destroy')->name('cart.rewardpoints.destroy');
