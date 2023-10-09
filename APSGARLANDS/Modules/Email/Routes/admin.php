<?php

use Illuminate\Support\Facades\Route;

Route::get('emails', [
    'as' => 'admin.emails.index',
    'uses' => 'EmailController@index',
    'middleware' => 'can:admin.emails.index',
]);

Route::get('emails/create', [
    'as' => 'admin.emails.create',
    'uses' => 'EmailController@create',
    'middleware' => 'can:admin.emails.create',
]);

Route::post('emails', [
    'as' => 'admin.emails.store',
    'uses' => 'EmailController@store',
    'middleware' => 'can:admin.emails.create',
]);

Route::get('emails/{id}/edit', [
    'as' => 'admin.emails.edit',
    'uses' => 'EmailController@edit',
    'middleware' => 'can:admin.emails.edit',
]);

Route::put('emails/{id}/edit', [
    'as' => 'admin.emails.update',
    'uses' => 'EmailController@update',
    'middleware' => 'can:admin.emails.edit',
]);

Route::delete('emails/{ids?}', [
    'as' => 'admin.emails.destroy',
    'uses' => 'EmailController@destroy',
    'middleware' => 'can:admin.emails.destroy',
]);
