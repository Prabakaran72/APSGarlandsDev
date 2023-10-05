@extends('admin::layout')

@component('admin::components.page.header')
    @slot('title', trans('ordersubscription::ordersubscriptions.ordersubscriptions'))

    <li class="active">{{ trans('ordersubscription::ordersubscriptions.ordersubscriptions') }}</li>
@endcomponent

@section('content')
    <div class="box box-default">
        <div class="box-body clearfix">
            <div class="col-lg-2 col-md-3">
                <div class="row">
                    <button class="btn btn-default add-root-ordersubscription">{{ trans('ordersubscription::ordersubscriptions.tree.add_root_category') }}</button>
                    <button class="btn btn-default add-sub-ordersubscription disabled">{{ trans('ordersubscription::ordersubscriptions.tree.add_sub_category') }}</button>

                    <div class="m-b-10">
                        <a href="#" class="collapse-all">{{ trans('ordersubscription::ordersubscriptions.tree.collapse_all') }}</a> |
                        <a href="#" class="expand-all">{{ trans('ordersubscription::ordersubscriptions.tree.expand_all') }}</a>
                    </div>

                    <div class="ordersubscription-tree"></div>
                </div>
            </div>

            <div class="col-lg-10 col-md-9">
                <div class="tab-wrapper ordersubscription-details-tab">
                    <ul class="nav nav-tabs">
                        <li class="general-information-tab active"><a data-toggle="tab" href="#general-information">{{ trans('ordersubscription::ordersubscriptions.tabs.general') }}</a></li>

                        @hasAccess('admin.media.index')
                            <li class="image-tab"><a data-toggle="tab" href="#image">{{ trans('ordersubscription::ordersubscriptions.tabs.image') }}</a></li>
                        @endHasAccess

                        <li class="seo-tab hide"><a data-toggle="tab" href="#seo">{{ trans('ordersubscription::ordersubscriptions.tabs.seo') }}</a></li>
                    </ul>

                    <form method="POST" action="{{ route('admin.ordersubscription.store') }}" class="form-horizontal" id="ordersubscription-form" novalidate>
                        {{ csrf_field() }}

                        <div class="tab-content">
                            <div id="general-information" class="tab-pane fade in active">
                                <div class="row">
                                    <div class="col-md-8">
                                        <div id="id-field" class="hide">
                                            {{ Form::text('id', trans('ordersubscription::attributes.id'), $errors, null, ['disabled' => true]) }}
                                        </div>

                                        {{ Form::text('name', trans('ordersubscription::attributes.name'), $errors, null, ['required' => true]) }}
                                        {{ Form::checkbox('is_searchable', trans('ordersubscription::attributes.is_searchable'), trans('ordersubscription::ordersubscriptions.form.show_this_category_in_search_box'), $errors) }}
                                        {{ Form::checkbox('is_active', trans('ordersubscription::attributes.is_active'), trans('ordersubscription::ordersubscriptions.form.enable_the_category'), $errors) }}
                                    </div>
                                </div>
                            </div>

                            @if (auth()->user()->hasAccess('admin.media.index'))
                                <div id="image" class="tab-pane fade">
                                    <div class="logo">
                                        @include('media::admin.image_picker.single', [
                                            'title' => trans('ordersubscription::ordersubscriptions.form.logo'),
                                            'inputName' => 'files[logo]',
                                            'file' => (object) ['exists' => false],
                                        ])
                                    </div>

                                    <div class="banner">
                                        @include('media::admin.image_picker.single', [
                                            'title' => trans('ordersubscription::ordersubscriptions.form.banner'),
                                            'inputName' => 'files[banner]',
                                            'file' => (object) ['exists' => false],
                                        ])
                                    </div>
                                </div>
                            @endif

                            <div id="seo" class="tab-pane fade">
                                <div class="row">
                                    <div class="col-md-8">
                                        <div class="hide" id="slug-field">
                                            {{ Form::text('slug', trans('ordersubscription::attributes.slug'), $errors) }}
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="col-md-offset-2 col-md-10">
                                <button type="submit" class="btn btn-primary" data-loading>
                                    {{ trans('admin::admin.buttons.save') }}
                                </button>

                                <button type="button" class="btn btn-link text-red btn-delete p-l-0 hide" data-confirm>
                                    {{ trans('admin::admin.buttons.delete') }}
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <div class="overlay loader hide">
            <i class="fa fa-refresh fa-spin"></i>
        </div>
    </div>
@endsection
