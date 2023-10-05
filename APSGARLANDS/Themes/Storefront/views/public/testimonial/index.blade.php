@extends('public.layout')
@section('title', trans('storefront::testimonial.testimonial'))
@section('content')
<br><br><h1 class="text-center">Testimonial Form</h1><br><br>
<div class="container">
    <div class="row justify-content-center align-items-center min-vh-80">
        <div class="col-md-6">
            <form action="{{ route('testimonials.store') }}" method="POST">
                @csrf
                <div class="form-group">
                    <label for="name">Your Name<span>*</span></label>
                    <input type="text" name="name" id="name" class="form-control" required>
                </div>
                <div class="form-group">
                    <label for="comment">Comment:<span>*</span></label>
                    <textarea name="comment" id="comment" class="form-control" rows="4" maxlength="200" required oninput="updateCharCount()"></textarea>
                    <p id="char-count">0 / 200 characters</p>
                </div>
                <button type="submit" class="btn btn-primary btn-block">
                    Submit
                </button>
            </form>
        </div>
    </div>  
</div>

<script>
    function updateCharCount() {
        const commentInput = document.getElementById('comment');
        const charCountElement = document.getElementById('char-count');
        const currentCharCount = commentInput.value.length;
        charCountElement.textContent = `${currentCharCount} / 200 characters`;
    }
</script>

@endsection
