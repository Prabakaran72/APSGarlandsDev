<?php

use Illuminate\Support\Facades\Route;

Route::get('templates', [
    'as' => 'admin.templates.index',
    'uses' => 'TemplateController@index',
    'middleware' => 'can:admin.templates.index',
]);

Route::get('templates/create', [
    'as' => 'admin.templates.create',
    'uses' => 'TemplateController@create',
    'middleware' => 'can:admin.templates.create',
]);

Route::post('templates', [
    'as' => 'admin.templates.store',
    'uses' => 'TemplateController@store',
    'middleware' => 'can:admin.templates.create',
]);

Route::get('templates/{id}/edit', [
    'as' => 'admin.templates.edit',
    'uses' => 'TemplateController@edit',
    'middleware' => 'can:admin.templates.edit',
]);

Route::put('templates/{id}/edit', [
    'as' => 'admin.templates.update',
    'uses' => 'TemplateController@update',
    'middleware' => 'can:admin.templates.edit',
]);

Route::delete('templates/{ids?}', [
    'as' => 'admin.templates.destroy',
    'uses' => 'TemplateController@destroy',
    'middleware' => 'can:admin.templates.destroy',
]);
