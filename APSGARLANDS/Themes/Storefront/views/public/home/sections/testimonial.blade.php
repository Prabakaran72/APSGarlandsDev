

@if (setting('testimonial_slider_enabled'))
<section>
    <div id="testimonial_slide_div"></div>
</section>
@endif
@if (setting('testimonial_slider_enabled'))
    <script>
        $(document).ready(function() {
            $.ajax({
                url: '{{ route('testimonials.slider') }}',
                method: 'GET',
                dataType: 'html', // Expect HTML content in response
                success: function(response) {
                    $('#testimonial_slide_div').html(response);
                    $('#testimonials-list').owlCarousel({
                        loop: true,
                        center: true,
                        items: 5, // Display 5 testimonials at a time
                        margin: 0,
                        autoplay: true,
                        dots: true,
                        autoplayTimeout: 2000,
                        smartSpeed: 450,
                        responsive: {
                            0: {
                                items: 1
                            },
                            768: {
                                items: 2
                            },
                            1170: {
                                items: 3
                            }
                        }
                    });
                },
                error: function() {
                    console.error('Error loading testimonials');
                }
            });
        });
    </script>
@endif