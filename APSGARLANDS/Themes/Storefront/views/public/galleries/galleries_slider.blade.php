
@if (setting('galleries_enabled'))
{{-- {{ dd($galleries) }} --}}
<div id="galleries-list" class="owl-carousel">
    @foreach ($galleries->reverse() as $gallery)
        @if ($gallery->is_active == 1)
            <div class="item">
                <div class="shadow-effect">
                    <p>{{ $gallery->channelTitle}}</p>
                    <iframe width="420" height="315"
                    src="https://www.youtube.com/embed/{{ $gallery->videoID }}?autoplay=0&mute=1">
                    </iframe>
                </div>
            </div>
        @endif
    @endforeach
</div>
@endif
