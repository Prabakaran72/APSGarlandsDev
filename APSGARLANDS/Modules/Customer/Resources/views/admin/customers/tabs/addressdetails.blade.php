<div class="row">
    <div class="col-md-5">{{ Form::text('address_1', trans('customer::attributes.address_1'), $errors, $customer, ['labelCol' => 3, 'required' => true]) }}</div>
   
    <div class="col-md-6">{{ Form::select('country', trans('customer::attributes.country'), $errors, $country, ['labelCol' => 3]) }}</div>    
</div>
    <div class="row">
        <div class="col-md-5">{{ Form::text('address_2', trans('customer::attributes.address_2'), $errors, $customer, ['labelCol' => 3,'placeholder'=>'Optional']) }}</div>
        <div class="store-state select hide">
        <div class="col-md-6">{{ Form::select('state', trans('customer::attributes.state'), $errors,$customer, ['labelCol' => 3, 'required' => true]) }}</div>
        </div>
    </div>
        <div class="row">
            <div class="col-md-5">{{ Form::text('city', trans('customer::attributes.city'), $errors, $customer, ['labelCol' => 3, 'required' => true ]) }}</div>
            <div class="col-md-6">{{ Form::text('zip', trans('customer::attributes.zip'), $errors, $customer, ['labelCol' => 3, 'required' => true]) }}</div>
            </div>

            <script>
                const countrySelect = document.getElementById("country");
                const stateSelectDiv = document.querySelector(".store-state.select");
                const stateSelect = stateSelectDiv.querySelector("select");
                
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
                            stateSelectDiv.classList.remove("hide");
                        })
                        .catch(error => {
                            console.error("An error occurred:", error);
                        });
                });
            </script>
            
            
     