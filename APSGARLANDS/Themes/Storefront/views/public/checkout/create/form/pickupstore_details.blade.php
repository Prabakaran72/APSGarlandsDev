<div class="pickup_store_details">
  <div v-if="form.shipping_method === 'local_pickup'">
    <h4 class="section-title">{{ trans('storefront::checkout.pickup_store_details') }}</h4>
    <div id="getLocalpickupAddress">
      <div class="select-address" v-cloak>
      <div class="form-group">
        <div v-if="pickupstore.length === 0">
          <p>Pickup store is currently not available</p>
        </div>
        <div v-else>
     <div class="form-radio" v-for="store in pickupstore" :key="store.id">
  <input type="radio" :id="'localpickup_address_' + store.id" :value="store.id" v-model="selectedLocalpickupAddressId">
  <label :for="'localpickup_address_' + store.id">
    <span v-text="store.first_name"></span>
    <span v-text="store.address_1"></span>
    <span v-if="store.address_2" v-text="store.address_2"></span>
    <span>@{{ store.city }}, @{{ stateCodeToNameMapping[store.state] }} @{{ store.zip }}</span>
    <span v-text="countries[store.country]"></span>
  </label>
</div>

      </div>
      </div></div>
    </div>
  </div></div>
  
