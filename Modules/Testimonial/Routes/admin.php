<?php

use Illuminate\Support\Facades\Route;

Route::get('testimonials', [
    'as' => 'admin.testimonials.index',
    'uses' => 'TestimonialController@index',
    'middleware' => 'can:admin.testimonials.index',
]);

Route::get('testimonials/create', [
    'as' => 'admin.testimonials.create',
    'uses' => 'TestimonialController@create',
    'middleware' => 'can:admin.testimonials.create',
]);

Route::post('testimonials', [
    'as' => 'admin.testimonials.store',
    'uses' => 'TestimonialController@store',
    'middleware' => 'can:admin.testimonials.create',
]);

Route::get('testimonials/{id}/edit', [
    'as' => 'admin.testimonials.edit',
    'uses' => 'TestimonialController@edit',
    'middleware' => 'can:admin.testimonials.edit',
]);

Route::put('testimonials/{id}', [
    'as' => 'admin.testimonials.update',
    'uses' => 'TestimonialController@update',
    'middleware' => 'can:admin.testimonials.edit',
]);

Route::delete('testimonials/{ids?}', [
    'as' => 'admin.testimonials.destroy',
    'uses' => 'TestimonialController@destroy',
    'middleware' => 'can:admin.testimonials.destroy',
]);
