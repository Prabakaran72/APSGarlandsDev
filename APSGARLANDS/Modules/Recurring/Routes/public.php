<?php

use Illuminate\Support\Facades\Route;

Route::post('public/recurrings/updateRecurringSubTotal', 'RecurringStoreFrontController@updateRecurringSubTotal')->name('recurring.subtotal.update');
