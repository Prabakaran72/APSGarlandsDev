<?php

use Illuminate\Support\Facades\Route;

// Route::get('/', 'HomeController@index')->name('home');
Route::get('unsubscribe', 'SubscriberController@unsubscribe')->name('unsubscribe');
Route::post('subscribers', 'SubscriberController@store')->name('subscribers.store');
Route::post('unsubscribers', 'SubscriberController@delete')->name('subscribers.delete');
