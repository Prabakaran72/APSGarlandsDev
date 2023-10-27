@extends('public.account.layout')

@section('title', trans('storefront::account.pages.my_blogform'))

@section('account_breadcrumb')
    <li class="active">{{ trans('storefront::account.pages.my_blogform') }}</li>
@endsection

@section('panel')
    <div class="panel">
        <div class="panel-header">
            <h4>{{ trans('storefront::account.pages.my_blogform') }}</h4>
                <button type="button" class="btn btn-primary" onclick="window.location.href='{{ route('account.blogform.create') }}'" >Create BlogPost</button>

        </div>

        <div class="panel-body">
            @if ($blogpost->isEmpty())
                <div class="empty-message">
                    <h3>{{ trans('storefront::account.blogform.no_blogform') }}</h3>
                </div>
            @else
                <div class="table-responsive">
                    <table class="table table-borderless my-reviews-table">
                        <thead>
                            <tr>
                                <th>{{ trans('storefront::account.blogform.category_name') }}</th>
                                <th>{{ trans('storefront::account.blogform.post_title') }}</th>
                                <th>{{ trans('storefront::account.blogform.post_description') }}</th>
                                <th>{{ trans('storefront::account.blogform.date') }}</th>
                                 <th>{{ trans('storefront::account.blogform.edit') }}</th>

                            </tr>
                        </thead>

                        <tbody>
                             @foreach ($blogpost as $blogposts)
                                <tr>
                                    <td>
                                        {{ $blogposts->category->category_name  }}
                                    </td><td>
                                        {{ $blogposts->post_title }}
                                    </td><td>
                                        <li>{{ str_limit(strip_tags($blogposts->post_body), 75) }}</li>
                                    </td>
                                    <td>
                                        {{ $blogposts->created_at->toFormattedDateString() }}
                                    </td>
                                    <td>
                                        @if($blogposts->post_status!='approved')
                                        <a href="{{ route('account.blogform.edit', $blogposts->id)  }}">
                                            <i class="las la-edit" style="font-size: 24px; font-weight: bold;color:#4e27dd"></i>
                                        </a>

                                        <a href="{{ route('account.blogform.destroy', $blogposts->id) }}"
                                            onclick="event.preventDefault();
                                                     if (confirm('Are you sure you want to delete this blog post?')) {
                                                         document.getElementById('delete-form').submit();
                                                     }"
                                         >
                                             <i class="las la-trash" style="font-size: 24px; font-weight: bold; color:#dd2727"></i>
                                         </a>

                                         <form id="delete-form" action="{{ route('account.blogform.destroy', $blogposts->id) }}" method="POST" style="display: none;">
                                             @csrf
                                             @method('DELETE')
                                         </form>
                                        @else
                                            <i class="las la-check-circle" style="font-size: 24px; font-weight: bold; color: #00ff00;"></i>
                                        @endif
                                    </td>

                                </tr>
                            @endforeach
                        </tbody>
                    </table>
                </div>
            @endif
        </div>
        <div class="panel-footer">
            {!! $blogpost->links() !!}
        </div>
    </div>
@endsection
 
