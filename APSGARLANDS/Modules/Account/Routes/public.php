<?php

use Illuminate\Support\Facades\Route;

Route::middleware('auth')->group(function () {
    Route::get('account', 'AccountDashboardController@index')->name('account.dashboard.index');

    Route::get('account/profile', 'AccountProfileController@edit')->name('account.profile.edit');
    Route::put('account/profile', 'AccountProfileController@update')->name('account.profile.update');

    Route::get('account/orders', 'AccountOrdersController@index')->name('account.orders.index');
    Route::get('account/orders/{id}', 'AccountOrdersController@show')->name('account.orders.show');

    Route::get('account/downloads', 'AccountDownloadsController@index')->name('account.downloads.index');
    Route::get('account/downloads/{id}', 'AccountDownloadsController@show')->name('account.downloads.show');

    Route::get('account/wishlist', 'AccountWishlistController@index')->name('account.wishlist.index');
    Route::get('account/testimonials', 'AccountTestimonialController@index')->name('account.testimonials.index');

    Route::get('account/reviews', 'AccountReviewController@index')->name('account.reviews.index');
    Route::get('account/blogs', 'AccountBlogformController@testindex')->name('account.blogs.index');
    Route::post('account/blogs/like/{id}', 'AccountBlogformController@handleLike')->name('account.blogs.handleLike');
    Route::post('account/blogs/dislike/{id}', 'AccountBlogformController@handleDislike')->name('account.blogs.handleDislike');
    Route::post('account/blogs/comments', 'AccountBlogformController@commentsstore')->name('account.blogs.commentsstore');
    Route::get('account/blogform', 'AccountBlogformController@index')->name('account.blogform.index');
    Route::get('account/blogform/create', 'AccountBlogformController@create')->name('account.blogform.create');
    Route::post('account/blogform/create1', 'AccountBlogformController@store')->name('account.blogform.store');
    Route::put('account/blogform/update/{id}', 'AccountBlogformController@update')->name('account.blogform.update');
    Route::delete('account/blogform/{id}', 'AccountBlogformController@destroy')->name('account.blogform.destroy');
    Route::get('account/blogform/edit/{id}', 'AccountBlogformController@edit')->name('account.blogform.edit');
    Route::get('account/blogs/blogsingle/{id}','AccountBlogformController@showMore')->name('account.blogs.blogSingle');

    Route::get('addresses', 'AccountAddressController@index')->name('account.addresses.index');
    Route::post('addresses', 'AccountAddressController@store')->name('account.addresses.store');
    Route::put('addresses/{id}', 'AccountAddressController@update')->name('account.addresses.update');
    Route::delete('addresses/{id}', 'AccountAddressController@destroy')->name('account.addresses.destroy');

    Route::post('addresses/change-default-address', 'AccountDefaultAddressController@update')->name('account.change_default_address');
});
