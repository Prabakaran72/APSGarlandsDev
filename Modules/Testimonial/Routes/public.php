<?php

use Illuminate\Support\Facades\Route;

Route::get('create_testimonials', 'TestimonialController@testindex')->name('create_testimonials');

Route::post('testimonials', 'TestimonialController@store')
    ->name('testimonials.store');

Route::get('testimonials_slider', 'TestimonialController@showTestimonialSlider')->name('testimonials.slider');

