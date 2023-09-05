<div class="row">
    <div class="col-md-8">
    {{-- @php dd($product)@endphp --}}
        {{ Form::number('prepare_days', trans('product::attributes.prepare_days'), $errors, $product, ['min' => 1]) }}
        {{ Form::textarea('pre_short_description', trans('product::attributes.pre_short_description'), $errors, $product) }}
        {{-- {{ Form::checkbox('is_active', trans('product::attributes.is_active'), trans('product::products.form.pre_order_status'), $errors, $product, ['checked' => true]) }} --}}
        {{ Form::checkbox('is_preorder_status', trans('product::attributes.is_preorder_status'), trans('product::products.form.pre_order_status'), $errors, $product) }}

       
    
    </div>
</div>