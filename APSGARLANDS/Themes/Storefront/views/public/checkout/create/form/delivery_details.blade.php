@auth
 
@endauth

<div class="billing-details">
    <h4 class="section-title">{{ trans('storefront::checkout.delivery_details') }}</h4>
<span ><strong>Set a Delivery Date Based On product</strong></span><br>

		
    <form>
		
		<div class="form-group" v-if="!form.isCheckedRecurringOrder">
		     <label for="delivery_date" class="col-md-5">
                 {{ trans('storefront::checkout.delivery_date') }}<span>*</span>
             </label>
			<div class="col-md-7" style="display: inline-block;">
			
			
			<input  type="date" name="delivery_date1" id="delivery_date1"   v-model="selectedDeliveryDate"   :min="minDate" class="form-control"/>
			
			{{--<input v-else type="date" name="delivery_date1" id="delivery_date1"  v-model="selectedDeliveryDate"   :min="minDate" class="form-control"/> --}}
			
		
			</div>
		</div>
		<div class="form-group" v-else>
		     
			
			
			<input  type="hidden" name="delivery_date1" id="delivery_date1"  value="0000-00-00" class="form-control"/>
			
			
			
		
			</div>
		
	</form>
   
</div>