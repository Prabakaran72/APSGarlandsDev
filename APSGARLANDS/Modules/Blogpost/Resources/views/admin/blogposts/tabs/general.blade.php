<div class="row">
    <div class="col-md-8">
        {{ Form::select('category_id', trans('blogpost::attributes.category_id'), $errors, $blogggcategorys, $blogpost, ['class' => 'selectize prevent-creation', 'required' => true]) }}
        {{ Form::select('tag_id', trans('blogpost::attributes.tag_id'), $errors, $blogggtags, $blogpost, ['class' => 'selectize prevent-creation']) }}
    </div>
</div>
{{ Form::text('post_title', trans('blogpost::attributes.post_title'), $errors, $blogpost, ['labelCol' => 2, 'required' => true]) }}
{{ Form::wysiwyg('post_body', trans('blogpost::attributes.post_body'), $errors, $blogpost, ['labelCol' => 2, 'required' => true]) }}
<div class="row">
    <div class="col-md-8">
        {{ Form::select('post_status', trans('blogpost::attributes.post_status'), $errors, ['pending' => 'Pending', 'approved' => 'Approved', 'rejected' => 'Rejected'], $blogpost, ['class' => 'selectize prevent-creation', 'onchange' => 'handleStatusChange(this)']) }}
        <input type="hidden" name="author_id" id='author_id' value="{{ auth()->id() }}">
    </div>
</div>
<input type="hidden" name="approved_date" id='approved_date' value="">
<input type="hidden" name="approved_by" id='approved_by' value="">

<script>
    function handleStatusChange(selectElement) {
        var selectedValue = selectElement.value;
        if (selectedValue === 'approved') {
            var currentDate = new Date();
            var year = currentDate.getFullYear().toString();
            var month = (currentDate.getMonth() + 1).toString().padStart(2, '0');
            var day = currentDate.getDate().toString().padStart(2, '0');
            var formattedDate = year + '-' + month + '-' + day;
            $("#approved_date").val(formattedDate);
            var author_id = $("#author_id").val();
            $("#approved_by").val(author_id);
        } else {
            $("#approved_date").val('');
            $("#approved_by").val('');
        }
    }
</script>
