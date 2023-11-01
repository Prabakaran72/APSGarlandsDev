@extends('public.layout')
@section('title', trans('storefront::testimonial.testimonial'))
@section('content') 
<br><br><h1 class="text-center">Unsubscribe</h1><br><br>
<div class="container">
    <div class="row justify-content-center align-items-center min-vh-80">
        <div class="col-md-6">
            <form action="{{ route('subscribers.delete') }}" method="POST">
                @csrf
                <div class="form-group">
                    <label for="email">email<span>*</span></label>
                    <input type="email" name="email" id="email" class="form-control" required>
                </div>
                <button type="submit" class="btn btn-primary btn-block">
                    Unsubscribe
                </button>
            </form>
        </div>
    </div>  
</div>

{{-- <script>
    function updateCharCount() {
        const commentInput = document.getElementById('comment');
        const charCountElement = document.getElementById('char-count');
        const currentCharCount = commentInput.value.length;
        charCountElement.textContent = `${currentCharCount} / 200 characters`;
    }
</script> --}}

@endsection
