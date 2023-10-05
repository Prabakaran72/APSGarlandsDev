<div class="row">
    <div class="col-md-8">
        <div class="box-content clearfix">
            {{ Form::text('name', trans('pickupstore::attributes.name'), $errors, $pickupstore, ['required' => true]) }}
            {{ Form::text('tagline', trans('pickupstore::attributes.tagline'), $errors, $pickupstore) }}
            {{ Form::email('email', trans('pickupstore::attributes.email'), $errors, $pickupstore , ['required' => true] ) }}

            {{-- {{ Form::text('translatable[store_name]', trans('setting::attributes.translatable.store_name'), $errors, $pickupstore, ['required' => true]) }}
            {{ Form::text('translatable[store_tagline]', trans('setting::attributes.translatable.store_tagline'), $errors, $pickupstore, ['rows' => 2]) }}
            {{ Form::text('store_email', trans('setting::attributes.store_email'), $errors, $pickupstore, ['required' => true]) }} --}}
            {{ Form::number('phone', trans('pickupstore::attributes.phone'), $errors, $pickupstore, ['required' => true]) }}
            {{ Form::text('address_1', trans('pickupstore::attributes.address_1'), $errors, $pickupstore) }}
            {{ Form::text('address_2', trans('pickupstore::attributes.address_2'), $errors, $pickupstore) }}
            {{ Form::text('city', trans('pickupstore::attributes.city'), $errors, $pickupstore, ['required' => true]) }}
            {{ Form::select('store_country', trans('pickupstore::attributes.store_country'), $errors,  $countries, $pickupstore, ['required' => true]) }}

            <div class="store-state input">
                {{ Form::text('store_state', trans('setting::attributes.store_state'), $errors, $pickupstore, ['required' => true]) }}
            </div>

            <div class="store-state select hide">
                {{ Form::select('store_state', trans('setting::attributes.store_state'), $errors, [], $pickupstore, ['required' => true]) }}
            </div>

            {{ Form::number('zip', trans('pickupstore::attributes.zip'), $errors, $pickupstore, ['required' => true]) }}
        </div>

        
    </div>
</div>

<div class="row">
    <div class="col-md-8">
        {{ Form::checkbox('is_active', trans('pickupstore::attributes.is_active'), trans('pickupstore::pickupstore.form.enable_the_pickupstore'), $errors, $pickupstore) }}
    </div>
</div>
<script>
    // Get a reference to the country select element
    const countrySelect = document.getElementById("store_country");

    // Get references to the state divs
    const stateInputDiv = document.querySelector(".store-state.input");
    const stateSelectDiv = document.querySelector(".store-state.select");

    // Get references to the state input and select elements
    const stateInput = stateInputDiv.querySelector("input");
    const stateSelect = stateSelectDiv.querySelector("select");

    // Store the initial state value
    const oldState = stateInput.value;

    // Add an event listener to the country select element
    countrySelect.addEventListener("change", (e) => {
        // Get the selected country value
        const selectedCountry = e.target.value;

        // Make an AJAX request
        fetch(route("countries.states.index", selectedCountry))
            .then((response) => response.json())
            .then((states) => {
                // Hide both state divs
                stateInputDiv.classList.add("hide");
                stateSelectDiv.classList.add("hide");

                // Check if the states object is empty
                if (Object.keys(states).length === 0) {
                    // If no states are available, show the input field and set its value
                    stateInputDiv.classList.remove("hide");
                    stateInput.value = oldState;
                } else {
                    // If states are available, populate and show the select field
                    for (const code in states) {
                        const option = document.createElement("option");
                        option.value = code;
                        option.textContent = states[code];
                        stateSelect.appendChild(option);
                    }

                    stateSelectDiv.classList.remove("hide");
                    stateSelect.value = oldState;
                }
            })
            .catch((error) => {
                console.error("An error occurred:", error);
            });
    });

    // Trigger the change event on page load
    countrySelect.dispatchEvent(new Event("change"));

    // // Get the select element by its ID
    // const select = document.getElementById('store_country');

    // // Set 'Malaysia' as the default selected option
    // select.value = 'MY';
</script>
