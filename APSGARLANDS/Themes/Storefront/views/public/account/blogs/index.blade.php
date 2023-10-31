<head>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
</head>
@extends('public.account.layout')
@section('title', trans('storefront::account.pages.my_blogform'))

@section('account_breadcrumb')
    <li class="active">{{ trans('storefront::account.pages.my_blogform') }}</li>
@endsection
@section('panel')
<h1 class="text-center">Blogs</h1><br><br>

<div class="container">

    <div class="row justify-content-center align-items-center min-vh-80">
        <div class="row blog-color">
            @foreach($Blogpost as $blogpost)
            <div class="col-md-12">
                <div class="card" style="width:100%">
                    @switch(true)
                    @case($blogpost->users->sso_google == '1' || $blogpost->users->sso_fb == '1')
					<div class="row">
					  <div class="col-md-3">
						<center><img src="{{ $blogpost->users->sso_avatar }}" alt="User Profile Image"  class="profile-image" width="100%" /></center>
					  </div>
					  <div class="col-md-9">
						<b>{{ $blogpost->users->first_name }}</b>
					  </div>
					</div>
                    @break
                    @case($blogpost->users->sso_fb == '' && $blogpost->users->sso_google == '' && (!empty($blogpost->users->image_url)))
					<div class="row">
					  <div class="col-md-3">
						<center><img src="{{ $blogpost->users->image_url }}" alt="User Profile Image" class="profile-image" width="100%" /></center>
					  </div>
					  <div class="col-md-9">
						<b>{{ $blogpost->users->first_name }}</b>
					  </div>
					</div>
                    @break
                    @default
                    <i class="las la-user-circle"></i>
                   <b>{{ $blogpost->users->first_name }}</b>
                    @endswitch
                    <div class="card-body blog-card" >
                        <p class="card-text"><b>{{ $blogpost->post_title }}</b></p>
                        <p class="card-text" >
                         {{ str_limit(strip_tags($blogpost->post_body), 100) }}
                     @if (strlen(strip_tags($blogpost->post_body)) > 100)
              ... <a href="{{ route('account.blogs.blogSingle',$blogpost->id) }}" class="more">Read More</a>
            @endif 
            </div> 
         
		 <div class="row">
		    <div class="col-md-6">
				<like-component :blog="{{ $blogpost->id }}"  :alldislikes="{{ $blogpost->dislikes() }}"  :alllikes="{{ $blogpost->likes() }}"></like-component>
			</div>
			<div class="col-md-6">	 
				<i class="las la-comment"></i> <div class="show-comments-btn" data-post-id="{{ $blogpost->id }}" onclick="toggleComments(this)">Show Comments</div>
		    </div>
		</div>
		 
        <div class="comments-section" id="comments-section-{{ $blogpost->id }}" style="display: none;">
            <h4>Display Comments</h4>
			
	   
        <button class="addshow-comments-btn" data-post-id="{{ $blogpost->id }}" onclick="addtoggleComments(this)">Add Comments</button>
            <div class="addcomments-section" id="addcomments-section-{{ $blogpost->id }}" style="display: none;">
                <form method="POST" action="{{ route('account.blogs.commentsstore') }}">

                        @csrf

                        <div class="form-group">

                            <textarea class="form-control" name="comments" id="comments"></textarea>

                            <input type="hidden" name="post_id" value="{{ $blogpost->id }}" />

                        </div>

                        <div class="form-group">

                            <input type="submit" class="btn btn-success" value="Add Comment" />

                        </div>

                </form>
			</div>
					
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
                    <i class="las la-user-circle"></i>@endswitch
                            {{ $comment->users->user_name }}<li>{{ $comment->comments }}</li>
        @endforeach
    </ul>
    </div>

            </div></div>
            @endforeach
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
    padding: 25px;
    background-color: #fff;
}
.full-content {
    display: none;
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

    function toggleComments(button) {
    var postId = button.getAttribute('data-post-id');
    var commentsSection = document.getElementById('comments-section-' + postId);

    if (commentsSection.style.display === 'none' || commentsSection.style.display === '') {
        commentsSection.style.display = 'block';
    } else {
        commentsSection.style.display = 'none';
    }
}
 function addtoggleComments(button) {
    var postId = button.getAttribute('data-post-id');
    var addcommentsSection = document.getElementById('addcomments-section-' + postId);

    if (addcommentsSection.style.display === 'none' || addcommentsSection.style.display === '') {
        addcommentsSection.style.display = 'block';
    } else {
        addcommentsSection.style.display = 'none';
    }
}  

</script>