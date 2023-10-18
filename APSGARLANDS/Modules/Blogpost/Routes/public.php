<?php

use Illuminate\Support\Facades\Route;

Route::get('/', 'HomeController@index')->name('home');
// Route::get('account/blogs', 'BlogpostController@testindex')->name('account.blogs.index');
// Route::post('account/blogs/like', 'BlogpostController@fetchLike')->name('account.blogs.fetchLike');
// Route::post('account/blogs/like/{id}', 'BlogpostController@handleLike')->name('account.blogs.handleLike');
// Route::get('account/blogsingle/{id}','BlogpostController@showMore')->name('account.blogs.blogSingle');

// Route::post('account/blogs/dislike', 'BlogpostController@fetchDislike')->name('account.blogs.fetchDislike');
// Route::post('account/blogs/dislike/{id}', 'BlogpostController@handleDislike')->name('account.blogs.handleDislike');
// Route::post('account/blogs/comments', 'BlogpostController@commentsstore')->name('account.blogs.commentsstore');

