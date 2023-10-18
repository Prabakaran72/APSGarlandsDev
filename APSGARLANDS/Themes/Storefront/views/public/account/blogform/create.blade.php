@extends('public.account.layout')

@section('title', trans('storefront::account.pages.my_blogform'))

@section('account_breadcrumb')
    <li class="active">{{ trans('storefront::account.pages.my_blogform') }}</li>
@endsection

@section('panel')
    <div class="panel">
        <div class="panel-header">
            <h4>{{ trans('storefront::account.pages.my_blogform') }}</h4>
                <button type="button" class="btn btn-primary" onclick="window.location='{{ route('account.blogform.index') }}'" >Back To List</button>

        </div>

        <div class="panel-body">
                <form action="{{ route('account.blogform.store') }}" method="POST">

            @csrf
        <div class="form-group">
            <label for="category">Category<span>*</span></label>
            <select class="form-control select2" id="category_id" name="category_id">
            <option value="">{{trans('storefront::account.blogform.select_category')}}</option>
                @foreach ($Blogcategory as $Blogcategorys)
                    <option value="{{ $Blogcategorys->id }}">{{ $Blogcategorys->category_name }}</option>
                @endforeach
            </select>
        </div>
        <div class="form-group">
            <label for="Tags">Tags<span>*</span></label>
            <select id="tag_id" name="tag_id[]" class="form-control select2" multiple>
                @foreach ($Blogtag as $Blogtags)
                    <option value="{{ $Blogtags->id }}">{{ $Blogtags->tag_name }}</option>
                @endforeach
            </select>
        </div>

             <div class="form-group">
                <label for="post_title">Post Title<span>*</span></label>
                <input type="text" name="post_title" id="post_title" class="form-control " required>
            </div>
            <div class="form-group">
                <label for="description">Description<span>*</span></label>
                <textarea name="post_body" rows="5"  id="post_body" class="editor form-control" ></textarea>
            </div>
            <input type="hidden" name="author_id" id="author_id" class="form-control" value={{auth()->id()}}>

            <button type="submit" class="btn btn-primary btn-block">
                Submit
            </button>
        </form>


        </div>


    </div>
@endsection
