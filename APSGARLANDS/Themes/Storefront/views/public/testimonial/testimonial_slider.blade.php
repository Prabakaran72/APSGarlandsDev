
@if (setting('testimonial_slider_enabled'))
<br><br><br>
<div class="container">
    <h3 class="title">TESTIMONIALS</h3>
</div>

<div id="testimonials-list" class="owl-carousel">
    @foreach ($testimonials as $testimonial)
        <div class="item">
            <div class="shadow-effect">
                <img class="imgPlaceholder" src="{{ $testimonial->user->image_url ? asset($testimonial->user->image_url) : asset('storage/profile/default.jpg') }}" alt="">
                <p>{{ $testimonial->comment }}</p>
            </div>
            <div class="testimonial-name">{{ $testimonial->user_name }}</div>
        </div>
    @endforeach
</div>

<br><br>
@endif
