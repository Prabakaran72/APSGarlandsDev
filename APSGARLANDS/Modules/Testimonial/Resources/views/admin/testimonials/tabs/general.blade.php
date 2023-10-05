<div class="row">
    <div class="col-md-8">

        {{ Form::text('user_name', trans('testimonial::attributes.name'), $errors, $testimonial, ['required' => true]) }}

        <div id="testimonial_cmd" oninput="updateCharCount()">
            {{ Form::textarea('comment', trans('testimonial::attributes.comment'), $errors, $testimonial, ['required' => true, 'rows' => 4, 'maxlength' => 200]) }}
        </div>
        <p id="char-count" style="position: relative; left: 160px;">0 / 200 characters</p><br>

        {{ Form::checkbox('is_active', trans('testimonial::attributes.is_active'), trans('testimonial::testimonials.form.enable_the_testimonial'), $errors, $testimonial) }}

    </div>

</div>
<script>
    function updateCharCount() {
        const commentInput = document.getElementById('comment');
        const charCountElement = document.getElementById('char-count');
        const currentCharCount = commentInput.value.length;
        charCountElement.textContent = `${currentCharCount} / 200 characters`;
    }
    updateCharCount();
</script>

