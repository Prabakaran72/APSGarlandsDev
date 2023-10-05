<div class="row">
    <div class="col-md-8">
        <div class="box-content clearfix">
            {{ Form::text('first_name', trans('customer::attributes.first_name'), $errors, $customer, ['labelCol' => 3, 'required' => true]) }}
            {{ Form::text('last_name', trans('customer::attributes.last_name'), $errors, $customer, ['labelCol' => 3, 'required' => true]) }}
            {{ Form::email('email', trans('customer::attributes.email'), $errors, $customer , ['required' => true] ) }}
            {{ Form::number('phone', trans('customer::attributes.phone'), $errors, $customer, ['required' => true]) }}
            {{ Form::text('address_1', trans('customer::attributes.address_1'), $errors, $customer) }}
            {{ Form::text('address_2', trans('customer::attributes.address_2'), $errors, $customer) }}
            {{ Form::text('city', trans('customer::attributes.city'), $errors, $customer, ['required' => true]) }}
            {{ Form::select('country', trans('customer::attributes.country'), $errors,  $countries, $customer, ['required' => true]) }}

            <div class="store-state input">
                {{ Form::text('state', trans('customer::attributes.state'), $errors, $customer, ['required' => true]) }}
            </div>

            <div class="store-state select hide">
                {{ Form::select('state', trans('customer::attributes.state'), $errors, [], $customer, ['required' => true]) }}
            </div>

            {{ Form::number('zip', trans('customer::attributes.zip'), $errors, $customer, ['required' => true]) }}
        </div>
    </div>
    <p>{{  $customer }}</p>
</div>

<script>
    // Get a reference to the country select element
    const countrySelect = document.getElementById("country");

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
        console.log('test');
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
    // const select = document.getElementById('country');

    // // Set 'Malaysia' as the default selected option
    // select.value = 'MY';
</script>