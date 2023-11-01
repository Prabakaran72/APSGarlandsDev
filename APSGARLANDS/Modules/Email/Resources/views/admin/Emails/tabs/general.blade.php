{{ Form::select('subscribers[]',trans('email::attributes.subscribers'),  $errors, $getSubscriber, ['labelCol' => 2, 'required' => true, 'multiple'=>true]) }}
{{ Form::text('subject', trans('email::attributes.subject'), $errors, $email, ['labelCol' => 2, 'required' => true]) }}
{{ Form::select('template', trans('email::attributes.template'), $errors, $getTemplate, ['labelCol' => 2, 'required' => true]) }}
{{ Form::text('date', trans('email::attributes.date'), $errors, $email, ['labelCol' => 2, 'required' => true]) }}
{{-- {{ Form::select('brand_id', trans('product::attributes.brand_id'), $errors, $product, $product) }} --}}
<div class="row">
    <div class="col-md-8">
        {{ Form::checkbox('is_active', trans('email::attributes.is_active'), trans('email::emails.form.enable_the_email'), $errors, $email) }}
    </div>
</div>



<!-- New Form for create email -->
<div class="form-group">
    <div class="col-md-2">
        <strong>Subscribers</strong>        
    </div>
    <div class="col-md-10">
        <select class='form-control'>
            <option>new</option>
            <option>data</option>
        </select>    
    </div>
</div>

<div class="form-group">
    <div class="col-md-2">
        <strong>Subject</strong>        
    </div>
    <div class="col-md-10">
        <input type='text' class='form-control'></input>        
    </div>
</div>

<div class="form-group">
    <div class="col-md-2">
        <strong>Template</strong>        
    </div>
    <div class="col-md-10">
        <select class='form-control'>
            <option>new</option>
            <option>data</option>
        </select>        
    </div>
</div>

<div class="form-group">
    <div class="col-md-2">
        <strong>Date</strong>        
    </div>
    <div class="col-md-10">
        <input type='date' class='form-control'></input>        
    </div>
</div>

<div class="form-group">
    <div class="col-md-2">
        <strong>Status</strong>        
    </div>
    <div class="col-md-10">
        <input type='checkbox' class=''></input>        
    </div>
</div>
