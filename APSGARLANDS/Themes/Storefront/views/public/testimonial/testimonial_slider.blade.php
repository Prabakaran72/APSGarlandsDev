
@if (setting('testimonial_slider_enabled'))
@php
    $imagePaths = [
        '0waO1nJgUIG8G1bR6g0zeSN2sAbzSdFXa4zz5MFA.jpg',
        'BSxaXfooF2GTRVLXdds9XBtG1ofXnBAMs5iCoQVN.jpg',
        'chfoQU5cJP4x0avmLFreBXajAUAVXaLfsYtQIGI9.jpg',
        'wz6mQw3tI8mEy6Hp5v2rlDFns9PbbkmGCZ93nCG4.jpg',
        'zjTBDysAwiRr2uce0DMufJOfYg5dgCJzUNhcX8Fg.jpg',
    ];

    $count = 0;
@endphp

<div id="testimonials-list" class="owl-carousel">
    @foreach ($testimonials->reverse() as $testimonial)
        @if ($testimonial->is_active == 1 && $count < 5)
            @php $imageIndex = $count % count($imagePaths); @endphp
            <div class="item">
                <div class="shadow-effect">
                    <img class="imgPlaceholder"
                        src="{{ asset('storage/testimonial_slider_img/' . $imagePaths[$imageIndex]) }}" alt="">
                    <p>{{ $testimonial->comment }}</p>
                </div>
                <div class="testimonial-name">{{ $testimonial->user_name }}</div>
            </div>
            @php $count++; @endphp
        @endif
    @endforeach
</div>

@endif
