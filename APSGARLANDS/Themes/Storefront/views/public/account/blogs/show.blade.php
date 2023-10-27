
@extends('public.account.layout')
@section('title', trans('storefront::account.pages.my_blogform'))
@section('account_breadcrumb')
<li class="active">{{ trans('storefront::account.pages.my_blogform') }}</li>
@endsection
@section('panel')
<br><br><h1 class="text-center">Blogs</h1><br><br>

<div class="container">

    <div class="row justify-content-center align-items-center min-vh-80">
        <div class="row">
       @empty($blogpost)

                <div class="empty-message">
                    <h3>{{ trans('storefront::account.blogform.no_blogform') }}</h3>
                </div>  @else
            <div class="col-md-12">
                <div class="card">

                    @switch(true)
                    @case($blogpost->users->sso_google == '1' || $blogpost->users->sso_fb == '1')
                            <img src="{{ $blogpost->users->sso_avatar }}" alt="User Profile Image"  class="profile-image" /><b>{{ $blogpost->users->first_name }}</b>
                    @break

                    @case($blogpost->users->sso_fb == '' && $blogpost->users->sso_google == '' && (!empty($blogpost->users->image_url)))
                            <img src="{{ $blogpost->users->image_url }}" alt="User Profile Image" class="profile-image" /><b>{{ $blogpost->users->first_name }}</b>
                    @break

                    @default
                    <i class="las la-user-circle"></i>
                    <b>{{ $blogpost->users->first_name }}</b>
                            @endswitch
                    <div class="card-body">
                    <p class="card-text"><b>{{ $blogpost->post_title }}</b></p>
                    <p class="card-text">

                   {!! strip_tags($blogpost->post_body) !!}</p>
                    </div>
                 
                      <like-component :blog="{{ $blogpost->id }}"  :alldislikes="{{ $blogpost->dislikes() }}"  :alllikes="{{ $blogpost->likes() }}"></like-component>
         
                <button class="show-comments-btn" data-post-id="{{ $blogpost->id }}" onclick="toggleCommentsblogs(this)">Show Comments</button>
                    <div class="comments-section" id="comments-section-{{ $blogpost->id }}" style="display: none;">
                <h4>Display Comments</h4>
       <ul>
        @foreach ($blogpost->blogcomments as $comment)
             @switch(true)
                    @case($comment->users->sso_google == '1' || $comment->users->sso_fb == '1')
                            <img src="{{ $comment->users->sso_avatar }}" alt="User Profile Image"  class="profile-image" /><b>{{ $comment->users->first_name }}</b>
                    @break
                    @case($comment->users->sso_fb == '' && $comment->users->sso_google == '' && (!empty($comment->users->image_url)))
                            <img src="{{ $comment->users->image_url }}" alt="User Profile Image" class="profile-image" /><b>{{ $comment->users->first_name }}</b>
                    @break
                    @default
                    <i class="las la-user-circle"></i> @endswitch
                            {{ $comment->users->user_name }}<li>{{ $comment->comments }}</li>
       
    </ul>
      @endforeach
    </div>
<button class="addshow-comments-btn" data-post-id="{{ $blogpost->id }}" onclick="addtoggleCommentsblogs(this)">Add Comments</button>
                    <div class="addcomments-section" id="addcomments-section-{{ $blogpost->id }}" style="display: none;">
                    <form method="POST" action="{{ route('account.blogs.commentsstore') }}">

                        @csrf
                    <h4>Add comment</h4>

                    <form method="POST" action="{{ route('account.blogs.commentsstore') }}">

                        @csrf

                        <div class="form-group">

                            <textarea class="form-control" name="comments" id="comments"></textarea>

                            <input type="hidden" name="post_id" value="{{ $blogpost->id }}" />

                        </div>

                        <div class="form-group">

                            <input type="submit" class="btn btn-success" value="Add Comment" />

                        </div>

                    </form></div>
            </div>
          @endif
        </div>
    </div>
</div>
@endsection

<style>
    .profile-image {
        width: 30px;
        height: 30px;
        border-radius: 50%; 
        border: 2px solid #fff; 
        box-shadow: 0 1px 2px rgba(0, 0, 0, 0.2); 
        object-fit: cover; 
    }
    .card {
    border: 1px solid #e1e1e1;
    border-radius: 8px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    padding: 100px;
    background-color: #fff;
}

.card-title {
    font-weight: bold;
    margin-bottom: 10px;
}

.card-text {
    color: #333;
}
    </style>
<script>

    function toggleCommentsblogs(button) {
    var postId = button.getAttribute('data-post-id');
    var commentsSection = document.getElementById('comments-section-' + postId);

    if (commentsSection.style.display === 'none' || commentsSection.style.display === '') {
        commentsSection.style.display = 'block';
    } else {
        commentsSection.style.display = 'none';
    }
}
function addtoggleCommentsblogs(button) {
    var postId = button.getAttribute('data-post-id');
    var addcommentsSection = document.getElementById('addcomments-section-' + postId);

    if (addcommentsSection.style.display === 'none' || addcommentsSection.style.display === '') {
        addcommentsSection.style.display = 'block';
    } else {
        addcommentsSection.style.display = 'none';
    }
}  

</script>