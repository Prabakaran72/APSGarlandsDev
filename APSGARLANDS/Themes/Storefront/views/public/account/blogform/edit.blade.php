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
                <form action="{{ route('account.blogform.update',$Blogpost->id) }}" method="POST">

            @csrf
            @method('PUT')
        <div class="form-group">
            <label for="category">Category<span>*</span></label>
            <select class="form-control select2" id="category_id" name="category_id">
            <option value="">{{trans('storefront::account.blogform.select_category')}}</option>
                @foreach ($Blogcategory as $Blogcategorys)
                    <option value="{{ $Blogcategorys->id }}"  @if ($Blogpost->category_id == $Blogcategorys->id)
                        selected
                    @endif>{{ $Blogcategorys->category_name }}</option>
                @endforeach
            </select>
        </div>
        <div class="form-group">
            <label for="Tags">Tags<span>*</span></label>
            <select id="tag_id" name="tag_id[]" class="form-control select2" multiple>
                @php
                $selectedTags = explode(',', $Blogpost->tag_id);
            @endphp
            @foreach ($Blogtag as $Blogtags)
            <option value="{{ $Blogtags->id }}"
                @if (in_array($Blogtags->id, $selectedTags))
                    selected
                @endif
            >
                {{ $Blogtags->tag_name }}
            </option>
                @endforeach
            </select>
        </div>

             <div class="form-group">
                <label for="post_title">Post Title<span>*</span></label>
                <input type="text" name="post_title" id="post_title" class="form-control " value={{$Blogpost->post_title}} required>
            </div>
            <div class="form-group">
                <label for="description">Description<span>*</span></label>
                <textarea name="post_body" rows="5"  id="post_body" class="editor form-control" >{{$Blogpost->post_body}}</textarea>
            </div>
            <input type="hidden" name="author_id" id="author_id" class="form-control" value={{auth()->id()}}>

            <button type="submit" class="btn btn-primary btn-block">
                Submit
            </button>
        </form>


        </div>


    </div>
@endsection
