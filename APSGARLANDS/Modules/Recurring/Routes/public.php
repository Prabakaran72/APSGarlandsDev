<?php

use Illuminate\Support\Facades\Route;

Route::post('updateRecurringSubTotal', 'RecurringStoreFrontController@updateRecurringSubTotal')->name('recurring.subtotal.update');

Route::post('storeRecurringDetails', 'RecurringStoreFrontController@storeRecurringDetails')->name('store.recurring.order');
