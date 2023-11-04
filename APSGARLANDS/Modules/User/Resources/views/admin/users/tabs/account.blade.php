<div class="row">
    <div class="col-md-8">
        {{ Form::text('first_name', trans('user::attributes.users.first_name'), $errors, $user, ['required' => true]) }}
        {{ Form::text('last_name', trans('user::attributes.users.last_name'), $errors, $user, ['required' => true]) }}
        {{ Form::email('email', trans('user::attributes.users.email'), $errors, $user, ['required' => true]) }}
        {{ Form::text('phone', trans('user::attributes.users.phone'), $errors, $user, ['required' => true]) }}
        {{ Form::select('roles', trans('user::attributes.users.roles'), $errors, $roles, $user, ['multiple' => true, 'required' => true, 'class' => 'selectize prevent-creation']) }}
        {{ Form::checkbox('user_type', trans('user::attributes.users.user_type'), trans('user::users.form.user_type'), $errors, $user) }}
        <input type="hidden" id="hidden_checkbox" name="user_type_hidden" value="">
        @if (request()->routeIs('admin.users.create'))
            {{ Form::password('password', trans('user::attributes.users.password'), $errors, null, ['required' => true]) }}
            {{ Form::password('password_confirmation', trans('user::attributes.users.password_confirmation'), $errors, null, ['required' => true]) }}
        @endif

        @if (request()->routeIs('admin.users.edit'))
            {{ Form::checkbox('activated', trans('user::attributes.users.activated'), trans('user::users.form.activated'), $errors, $user, ['disabled' => $user->id === $currentUser->id, 'checked' => old('activated', $user->isActivated())]) }}
        @endif

        
            @php
            echo '<script>
                var oldStateObject = "";
                </script>';
            $filteredAddress = collect($user->addresses)->filter(function ($address) {
                return $address->user_type == 1;
            })->first();
            // $filteredAddressJson = $filteredAddress ? json_encode($filteredAddress) : null;
            if(isset(  $filteredAddress)){
                echo '<script>
                   
                const oldState = \'' . json_encode($filteredAddress->state) . '\';
                oldStateObject = JSON.parse(oldState);
                </script>';

            }
            
        @endphp
        <input type="number" value={{ isset($filteredAddress) ? $filteredAddress->id : '' }} name="user_address"
        id="user_address" hidden>
        
        <div class="{{ old('user_type', array_get($user, 'user_type')) ? '' : 'hide' }}" id="address-fields">
            {{ Form::text('address_1', trans('user::attributes.users.address_1'), $errors, isset(  $filteredAddress) ?   $filteredAddress : $user, ['required' => true]) }}
            {{ Form::text('address_2', trans('user::attributes.users.address_2'), $errors, isset(  $filteredAddress) ?   $filteredAddress : $user, ['labelCol' => 3, 'placeholder' => 'Optional']) }}
            {{ Form::text('city', trans('user::attributes.users.city'), $errors, isset(  $filteredAddress) ?   $filteredAddress : $user, ['labelCol' => 3, 'required' => true]) }}
            {{ Form::text('zip', trans('user::attributes.users.zip'), $errors, isset(  $filteredAddress) ?   $filteredAddress : $user, ['labelCol' => 3, 'required' => true]) }}
            {{ Form::select('country', trans('user::attributes.users.country'), $errors, $countries, isset(  $filteredAddress) ? ['country' =>   $filteredAddress] : $countries, ['labelCol' => 3, 'required' => true]) }}
            {{ Form::select('state', trans('user::attributes.users.state'), $errors, [], isset(  $filteredAddress) ?   $filteredAddress : $user, ['labelCol' => 3, 'required' => true]) }}
            {{-- {{ Form::select('state', trans('user::attributes.users.state'), $errors, [], $user->addresses[0], ['required' => true]) }} --}}
        </div>
    </div>
</div>
<script>
   
    const addressFields = document.getElementById('address-fields');
    const user_type = document.getElementById('user_type');
    const hiddenCheckbox = document.getElementById("hidden_checkbox");
    const form = document.querySelector("form");
    const userAddress = document.getElementById('user_address');
    const firstName = document.getElementById('first_name');
    user_type.addEventListener('change', () => {
        addressFields.classList.toggle('hide');
        countrySelect.dispatchEvent(new Event("change"));
    });
    const countrySelect = document.getElementById("country");
    // const stateSelectDiv = document.querySelector(".store-state.select");
    countrySelect.value = 'MY';
    const stateSelect = document.getElementById("state");

    if (user_type.checked) {
        user_type.addEventListener("click",function(){
            event.preventDefault();
            
       });
       countrySelect.dispatchEvent(new Event("change"));
        // Make an AJAX request to fetch states based on the selected country
        fetch(route("countries.states.index", countrySelect.value))
            .then(response => response.json())
            .then(states => {
                // Clear existing options in the state select
                stateSelect.innerHTML = "";
                // Check if the states object is empty
                if (Object.keys(states).length === 0) {
                    // If no states are available, add "No states available" option
                    const noStatesOption = document.createElement("option");
                    noStatesOption.value = "";
                    noStatesOption.textContent = "No states available";
                    stateSelect.appendChild(noStatesOption);
                } else {
                    // Populate the state select with the new options
                    // console.log('states object is empty');
                    for (const code in states) {
                        const option = document.createElement("option");
                        option.value = code;
                        option.textContent = states[code];
                        stateSelect.appendChild(option);
                        // console.log('option.value',option.value);
                        if (option.value === oldStateObject) {
                                option.selected = true;
                               
                               
                        }
                    }
                    // console.log('oldStateObject',oldStateObject);

                }

                // Show the state select
                // stateSelectDiv.classList.remove("hide");
            })
            .catch(error => {
                console.error("An error occurred:", error);
            });
    }
    // Add an event listener to the country select element
    countrySelect.addEventListener("change", () => {

        const selectedCountry = countrySelect.value;

        // Make an AJAX request to fetch states based on the selected country
        fetch(route("countries.states.index", selectedCountry))
            .then(response => response.json())
            .then(states => {
                // Clear existing options in the state select
                stateSelect.innerHTML = "";
                // Check if the states object is empty
                if (Object.keys(states).length === 0) {
                    // If no states are available, add "No states available" option
                    const noStatesOption = document.createElement("option");
                    noStatesOption.value = "";
                    noStatesOption.textContent = "No states available";
                    stateSelect.appendChild(noStatesOption);
                } else {
                    // Populate the state select with the new options
                    for (const code in states) {
                        const option = document.createElement("option");
                        option.value = code;
                        option.textContent = states[code];
                        stateSelect.appendChild(option);
                    }
                }

                // Show the state select
                // stateSelectDiv.classList.remove("hide");
            })
            .catch(error => {
                console.error("An error occurred:", error);
            });
    });

    // if(firstName.value === ''){
    //     countrySelect.dispatchEvent(new Event("change"));
    // }
         
    
     
</script>


