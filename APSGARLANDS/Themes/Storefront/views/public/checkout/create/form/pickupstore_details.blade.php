
<div class="pickup_store_details">
<div v-if="form.shipping_method !== 'flat_rate'">
  <h4 class="section-title">{{ trans('storefront::checkout.pickup_store_details') }}</h4>
  <div id="getLocalpickupAddress">
    <div class="select-address" v-cloak>
    <div class="form-group">
      <div v-if="pickupstore.length === 0">
        <p>Pickup store is currently not available</p>
      </div>
      <div v-else>
    <div class="form-radio" v-for="address in pickupstore" :key="address.id">
      <input type="radio" :id="'localpickup_address_' + address.id" :value="address.id" v-model="selectedLocalpickupAddressId">
      <label :for="'localpickup_address_' + address.id">
        <span v-text="address.first_name"></span>
        <span  v-text="address.address_1"></span>
        <span v-if="address.address_2" v-text="address.address_2"></span>
        <span>@{{ address.city }}, @{{ stateCodeToNameMapping[address.state] }} @{{ address.zip }}</span>
        <span v-text="countries[address.country]"></span>
      </label>
    </div>
    </div>
    </div></div>
  </div>
</div></div>
