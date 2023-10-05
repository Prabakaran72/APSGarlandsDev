<form class="form-horizontal" id="order_create_form" enctype="multipart/form-data" novalidate>
    {{ csrf_field() }}
    <div class="row">
        <div class="col-md-8">
            <div class="box-content clearfix">


                <div class="row">

                    <div class="col-md-5">
                        <div class="form-group">
                            <label for="user" class="col-md-3 control-label text-left">Customer Name <span
                                    class="m-l-5 text-red">*</span></label>
                            <div class="col-md-9">
                                @if (isset($order))
                                    {{-- <input type="text" class="form-control" value="{{ $order->customer_first_name }} {{ $order->customer_last_name }}" readonly> --}}
                                    <select name="user" class="form-control custom-select-black " id="user"
                                        disabled>


                                        <option value={{ $order->id }} select>{{ $order->customer_full_name }}
                                        </option>

                                    </select>
                                @else
                                    <select name="user" class="form-control custom-select-black " id="user">
                                        <option value="0">Select Option</option>
                                        @foreach ($users as $user)
                                            <option value={{ $user->ids }}>{{ $user->fullname }}</option>
                                        @endforeach
                                    </select>

                                @endif

                                <span id="user_error" class="text-red"></span>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="customer_id" class="col-md-3 control-label text-left">Customer Id</label>
                            <div class="col-md-9">
                                <input name="customer_id" class="form-control " id="customer_id"
                                    value="{{ isset($order) ? $preff . $order->customer_id : '' }} " type="text"
                                    readonly>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row">

                    <div class="col-md-5">
                        <div class="form-group">
                            <label for="date" class="col-md-3 control-label text-left">Order Date</label>
                            <div class="col-md-9">
                                <input type="text" class="form-control"
                                    value={{ isset($order) ? $order->created_at : $date }} readonly>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="email" class="col-md-3 control-label text-left">Email<span
                                    class="m-l-5 text-red">*</span>

                            </label>
                            <div class="col-md-9">

                                @if (isset($order))
                                    <input name="customer_email" class="form-control" id="customer_email"
                                        value="{{ $order->customer_email }}" readonly>
                                @else
                                    <input name="customer_email" class="form-control" id="customer_email" value=""
                                        labelcol="3" type="email">
                                @endif
                                <span id="email_error" class="text-red"></span>
                            </div>
                        </div>
                    </div>
                </div>


                <div class="row">
                    <div class="col-md-5">
                        <div class="form-group">
                            <label for="phone" class="col-md-3 control-label text-left">Phone Number<span
                                    class="m-l-5 text-red">*</span>
                            </label>
                            <div class="col-md-9">

                                @if (isset($order))
                                    <input name="customer_phone" class="form-control" id="customer_phone"
                                        value="{{ $order->customer_phone }}" readonly>
                                @else
                                    <input name="customer_phone" class="form-control " id="customer_phone"
                                        value="" labelcol="3" type="text">
                                @endif

                                <span id="phone_error" class="text-red"></span>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="date" class="col-md-3 control-label text-left">Customer Group</label>
                            <div class="col-md-9">
                                <input type="text" class="form-control" value="Register" readonly>
                            </div>
                        </div>
                    </div>



                </div>


                <div class="row">
                    <div class="col-md-5">
                        <div class="form-group">
                            <label for="user" class="col-md-3 control-label text-left">Payment Method <span
                                    class="m-l-5 text-red">*</span></label>
                            <div class="col-md-9">

                                <input name="payment_method" class="form-control " id="payment_method" value="COD"
                                    type="text" readonly>
                                {{-- <select name="payment_method" class="form-control custom-select-black " id="payment_method">
                                <option value="0">Select Option</option>
                                <option value="COD" {{ isset($order) && $order->payment_method === 'COD' ? 'selected' : '' }}>COD</option>
                            </select> --}}
                                <span id="payment_method_error" class="text-red"></span>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="user" class="col-md-3 control-label text-left">Order Status<span
                                    class="m-l-5 text-red">*</span></label>
                            <div class="col-md-9">
                                <select name="status" class="form-control custom-select-black " id="status">
                                    <option value="0">Select Option</option>
                                    @foreach (trans('order::statuses') as $name => $label)
                                        <option value="{{ $name }}"
                                            {{ isset($order) && $order->status === $name ? 'selected' : '' }}>
                                            {{ $label }}</option>
                                    @endforeach
                                </select>
                                <span id="status_error" class="text-red"></span>
                            </div>
                        </div>
                    </div>


                </div>

                <input name="user_type" id="user_type" value="{{ isset($order) ? $order->user_type : '' }}"
                    labelcol="3" type="text" hidden>

                <input name="order_id" id="order_id" value="{{ isset($order) ? $order->id : '' }}" labelcol="3"
                    type="text" hidden>

                <input name="total_amt" id="total_amt" value="{{ isset($order) ? $order->total : '' }}"
                    labelcol="3" type="text" hidden>

                <input name="subtotal_amt" id="subtotal_amt" value="{{ isset($order) ? $order->sub_total : '' }}"
                    labelcol="3" type="text" hidden>
                <input name="coupon_id" id="coupon_id" value="" labelcol="3" type="number" hidden>
                <input name="discount_amt" id="discount_amt" value="" labelcol="3" type="text" hidden>

                <input name="discount_type" id="discount_type" value="" labelcol="3" type="text" hidden>

                <input name="sub_amt_coupon" id="sub_amt_coupon" value="" labelcol="3" type="text"
                    style="display: none;">


                <div class="address-information-wrapper" id="addressInformationWrapper">
                    <h3 class="section-title">Address Information</h3>
                    <hr>
                    <div class="other_address" style="display:none">
                        <input type="checkbox" id="other_address" name="other_address" value="1">
                        <label for="myCheckbox">ship to different address ?</label>

                    </div>
                    <div class="row address">

                        <div class="col-md-6">
                            <div class="billing-address" id="billing-address"
                                style="
                        display: inline-flex;
                        flex-wrap: nowrap;
                        flex-direction: column;
                    ">
                                <h4 class="pull-left">Billing Address</h4>

                                <div class="form-radio">

                                    <label for="billing-address_input">
                                        <span>
                                            <hr>
                                            @if (isset($order))
                                                <br>
                                                {{ $order->billing_address_1 }}
                                                <br>

                                                @if ($order->billing_address_2)
                                                    {{ $order->billing_address_2 }}
                                                    <br>
                                                @endif

                                                {{ $order->billing_city }}
                                                <br>
                                                {{ $order->billing_zip }}
                                                <br>
                                                {{ $order->shipping_state_name }}
                                                <br>
                                                {{ $order->billing_country_name }}
                                            @else
                                            @endif
                                        </span>
                                    </label>
                                </div>

                            </div>
                        </div>



                        <div class="col-md-6">

                            <div class="shipping-address" id="shipping-address"
                                style="display:none; flex-wrap: nowrap;
                        flex-direction: column;">
                                <h4 class="pull-left">Shipping Address</h4>
                                {{-- <div class="form-radio-shipping">
                                <input type="radio" id="shipping-address_input" value="1" hidden> --}}
                                <label for="shipping-address_input">
                                    <span>
                                        <hr>
                                        @if (isset($order))
                                            <br>
                                            {{ $order->shipping_address_1 }}
                                            <br>

                                            @if ($order->shipping_address_2)
                                                {{ $order->shipping_address_2 }}
                                                <br>
                                            @endif

                                            {{ $order->shipping_city }}
                                            <br>
                                            {{ $order->shipping_zip }}
                                            <br>
                                            {{ $order->shipping_state_name }}
                                            <br>
                                            {{ $order->shipping_country_name }}
                                        @else
                                        @endif
                                    </span>
                                </label>
                                {{-- </div> --}}
                            </div>



                        </div>

                    </div>
                </div>
            </div>

            <div class="items-ordered-wrapper">
                <h3 class="section-title">Items Ordered</h3>

                <div class="row">
                    <div class="col-md-12">
                        <div class="items-ordered">
                            <div class="table-responsive">
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th>{{ trans('order::orders.create_product_sublist.product') }}</th>
                                            <th>{{ trans('order::orders.create_product_sublist.unit_price') }}</th>
                                            <th>{{ trans('order::orders.create_product_sublist.quantity') }}</th>
                                            <th>{{ trans('order::orders.create_product_sublist.line_total') }}</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>

                                    <tbody id="productTableBody">
                                        @if (isset($order))
                                            @if (isset($order))
                                                @foreach ($order->products as $index => $pro)
                                                    <tr>
                                                        <td>
                                                            <select name="order_products{{ $index }}"
                                                                class="order-product" data-info="0"
                                                                id="order_products{{ $index }}">
                                                                <option value="0">Select Option</option>
                                                                @foreach ($products as $product)
                                                                    <option value="{{ $product->id }}"
                                                                        data-info="{{ $product->price }}"
                                                                        @if ($order->products->contains('product_id', $product->id) && $pro->product_id == $product->id) selected="selected" @endif>
                                                                        {{ $product->slug }}
                                                                    </option>
                                                                @endforeach
                                                            </select>
                                                            <div> <span id="order_products_error{{ $index }}"
                                                                    class="text-red"></span></div>
                                                        </td>

                                                        <td>{{ $pro->unit_price->format() }}</td>
                                                        <td><input type="text" name="qty{{ $index }}"
                                                                id="qty{{ $index }}" class="quantity"
                                                                value="{{ $pro->qty }}">
                                                            <div> <span id="qty_error{{ $index }}"
                                                                    class="text-red"></span></div>
                                                        </td>
                                                        <td>{{ $pro->line_total->format() }}</td>
                                                        <td>
                                                            <button class="btn btn-primary add-row"
                                                                id="add_product{{ $index }}">Add</button>
                                                            <button class="btn btn-danger delete-row"
                                                                id="delete_product{{ $index }}">Delete</button>
                                                        </td>
                                                    </tr>
                                                @endforeach
                                            @endif
                                        @else
                                            <tr>
                                                <td>

                                                    <select name="order_products" class="order-product"
                                                        data-info="0" id="order_products">
                                                        <option value="0">Select Option</option>
                                                        @foreach ($products as $product)
                                                            <option value="{{ $product->id }}"
                                                                data-info="{{ $product->price }}">
                                                                {{ $product->slug }}
                                                            </option>
                                                        @endforeach
                                                    </select>
                                                    <div> <span id="order_products_error" class="text-red"></span>
                                                    </div>
                                                </td>

                                                <td>MYR&nbsp;0.00</td>
                                                <td><input type="text" name="qty" id="qty"
                                                        class="quantity">
                                                    <div> <span id="qty_error" class="text-red"></span></div>
                                                </td>
                                                <td>MYR&nbsp;0.00</td>
                                                <td>
                                                    <button class="btn btn-primary add-row"
                                                        id="add_product">Add</button>
                                                    <button class="btn btn-danger delete-row"
                                                        id="delete_product">Delete</button>
                                                </td>
                                            </tr>

                                        @endif

                                    </tbody>

                                    <tfoot>
                                        <tr class="subtotal-row">
                                            <td></td>
                                            <td></td>
                                            <td>SubTotal:</td>
                                            <td> MYR {{ isset($order) ? $order->sub_total : '' }}</td>
                                            <td></td>
                                        </tr>
                                        <tr class="discount-row" style="display: none;">
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td>MYR: </td>
                                            <td></td>

                                        </tr>
                                        <tr class="total-row">
                                            <td>
                                                <input type="text" class="coupon" id="coupon" name="coupon"
                                                    placeholder="Enter coupon code">
                                                <button class="btn btn-primary coupon_btn" id="coupon_btn"
                                                    name="coupon_btn">Apply Coupon</button>
                                                <br>
                                                <span id="coupon_error" class="text-red"></span>
                                            </td>
                                            <td></td>
                                            <td>Total:</td>
                                            <td> MYR {{ isset($order) ? $order->total : '' }}</td>
                                            <td></td>
                                        </tr>
                                    </tfoot>
                                </table>
                                {{-- <button class="btn btn-success" id="submitForm">Submit</button> --}}



                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="form-group">
        <div class="col-md-offset-3 col-md-10">
            <button id="{{ isset($order) ? 'editForm' : 'submitForm' }}" class="btn btn-primary">
                {{ trans('order::orders.buttons.save') }}
            </button>
        </div>
    </div>
</form>

<script>
    const user = document.getElementById('user');
    const textInput = document.getElementById('customer_id');
    const emailInput = document.getElementById('customer_email');
    const phoneInput = document.getElementById('customer_phone');
    const user_typeInput = document.getElementById('user_type');
    const billingAddress = document.querySelector('.billing-address span');
    const shippingAddress = document.querySelector('.shipping-address span');
    // const formRadio = document.querySelector('.form-radio input');
    // const formRadio_shipping = document.querySelector('.form-radio-shipping input');
    const addressDiv = document.getElementById('address-information-wrapper');
    const other_address = document.querySelector('.other_address');
    const other_address_value = other_address.value;
    let original_billing_address = {};
    let original_shipping_address = {};

    user.addEventListener('change', function() {
        textInput.value = user.value;
        const id = user.value;
        const billingData = {};
        const billingDataArray = [];
        emailInput.value = "";
        phoneInput.value = "";
        shippingAddress.innerHTML = "";
        billingAddress.innerHTML = "";
        fetch(route("admin.orders.print.details", id))
            .then(response => response.json())
            .then(data => {
                // Access the 'user' object
                const userObj = data.data;

                if (Array.isArray(userObj)) {
                    // Access the 'address' object
                    const addressObj = data.data[0].address;
                    const addressline_user = [];
                    const desiredKeys = ["phone", "email", "address_1", "address_2", "city", "state_name",
                        "zip", "country_name"
                    ];
                    const fromUser = true;
                    const user_data = data.data[0].user;
                    addressObj.forEach(item => {
                        // Access and print key-value pairs of each object
                        for (const key in item) {
                            if (item.hasOwnProperty(key)) {
                                const value_user = item[key]
                                if (desiredKeys.includes(key)) {
                                    const value = item[key];

                                    const address_user = value;
                                    addressline_user.push(address_user);
                                }
                            }
                        }


                    });


                    other_address.style.display = '';

                    const other_address_input = document.getElementById('other_address');
                    other_address_input.addEventListener('change', function() {
                        const shippingAddress = document.getElementById('shipping-address');
                        if (this.checked) {

                            shippingAddress.style.display = 'inline-flex';
                        } else {
                            shippingAddress.style.display = 'none';
                        }
                    });





                    console.log('other_address', other_address);
                    addAddress(addressObj, fromUser);
                    //  console.log('addressline_user',addressline_user);
                    // const desiredOrder = [0, 1, 2, 3, 5, 4];
                    // const rearrangedArray = desiredOrder.map(index => addressline_user[index]);
                    // const formattedAddress = addressline_user.join('<br>\n');

                    //     billingAddress.innerHTML = `<hr>${formattedAddress}`;
                    //     shippingAddress.innerHTML = `<hr>${formattedAddress}`;


                    phoneInput.value = user_data.phone;
                    emailInput.value = user_data.email;
                    user_typeInput.value = 'Login';

                } else {
                    other_address.style.display = 'none';
                    shippingAddress.style.display = 'none';
                    // formRadio.setAttribute('hidden', 'true');
                    // formRadio_shipping.setAttribute('hidden', 'true');
                    const keys = Object.keys(userObj);
                    const desiredKeys = ["phone", "email", "address_1", "address_2", "city", "state_name",
                        "zip", "country_name"
                    ];
                    const addressLines = [];
                    billingData['billing_address_1'] = userObj.address_1 || '';
                    billingData['billing_address_2'] = userObj.address_2 || '';
                    billingData['billing_city'] = userObj.city || '';
                    billingData['billing_zip'] = userObj.zip || '';
                    billingData['billing_state'] = userObj.state_name || '';
                    billingData['billing_country'] = userObj.country_name || '';

                    for (const key in userObj) {
                        if (desiredKeys.includes(key)) {
                            const value = userObj[key];
                            // console.log(`${key}: ${value}`);
                            if (key == 'phone') {
                                phoneInput.value = value;
                            } else if (key == 'email') {
                                emailInput.value = value;
                            } else {
                                const addressLine = value;

                                addressLines.push(addressLine);

                            }
                            // console.log('value',value);
                        }

                    }

                    // new ADDRESS LINE CODE
                    addAddress(billingData);
                    // ----------------------------------------------------------------
                    // console.log('addressLines',addressLines);
                    // const formattedAddress = addressLines.join('<br>\n');
                    // billingAddress.innerHTML = `<hr>${formattedAddress}`;
                    // shippingAddress.innerHTML = `<hr>${formattedAddress}`;
                    user_typeInput.value = 'Manual';

                }

            });

        function addAddress(address, fromUser = false) {

            const billingAddressContainer = document.getElementById('billing-address');
            const shippingAddressContainer = document.getElementById('shipping-address');
            let radioInput = '';
            let label = '';
            let formRadio = '';
            let span = '';
            let billingLines = [];
            const formRadioElements = billingAddressContainer.querySelectorAll('.form-radio');

            formRadioElements.forEach((formRadio) => {
                // Remove each form-radio element
                formRadio.remove();
            });
            const shippingformRadioElements = shippingAddressContainer.querySelectorAll('.form-radio');
            shippingformRadioElements.forEach((formRadio) => {
                // Remove each form-radio element
                formRadio.remove();
            });
            if (fromUser) {
                address.forEach((item, index) => {
                    formRadio = document.createElement('div');
                    formRadio.classList.add('form-radio');
                    radioInput = document.createElement('input');
                    radioInput.type = 'radio';
                    radioInput.name = 'billing-address';
                    radioInput.id = `billing-address-${item.id}`;
                    radioInput.value = `${item.id}`;
                    radioInput.checked = true;
                    label = document.createElement('label');
                    label.htmlFor = `billing-address-${item.id}`;
                    const addressDetails = ["address_1", "address_2", "city", "zip", "state_name",
                        "country_name"
                    ];
                    addressDetails.forEach((detailKey) => {
                        const span = document.createElement('span');
                        span.textContent = `${item[detailKey]}`;
                        label.appendChild(span);
                        if (index < addressDetails.length - 1) {
                            const lineBreak = document.createElement('br');
                            label.appendChild(
                            lineBreak); // Append a line break after each <span> except the last one
                        }

                    });

                    // span = document.createElement('span');
                    // label.appendChild(span);
                    formRadio.appendChild(radioInput);
                    formRadio.appendChild(label);
                    billingAddressContainer.appendChild(formRadio);
                    radioInput.addEventListener('change', function() {
                        if (this.checked) {
                            original_billing_address = {};
                            billingLines = [];
                            // const shippingAddressDisplay = document.getElementById('shipping-address');
                            // const shippingformRadioElements = shippingAddressDisplay.querySelectorAll('.form-radio');
                            // shippingformRadioElements.forEach((formRadio) => {
                            //     // Remove each form-radio element
                            //     formRadio.remove();
                            // });
                            const formRadio = this.closest('.form-radio');
                            const spanTags = formRadio.querySelectorAll('span');
                            //    const shippingformRadio = document.createElement('div');
                            //    shippingformRadio.classList.add('form-radio');
                            spanTags.forEach((spanTag) => {
                                // const clonedSpan = spanTag.cloneNode(true);
                                // shippingformRadio.appendChild(clonedSpan);
                                // const data = spanTag.innerText;
                                const data = spanTag.textContent;
                                billingLines.push(data);
                                original_billing_address = {
                                    'billing_address_1': billingLines[0],
                                    'billing_address_2': billingLines[1],
                                    'billing_city': billingLines[2],
                                    'billing_zip': billingLines[5],
                                    'billing_state': billingLines[4],
                                    'billing_country': billingLines[3]
                                }
                            });

                            //   shippingAddressDisplay.appendChild(shippingformRadio);
                            console.log('Addressdata', original_billing_address);

                        }
                    });
                   

                });

                const billinaAddressDiv = billingAddressContainer.querySelectorAll('.form-radio');
                billinaAddressDiv.forEach((element) => {
                    const clonedElement = element.cloneNode(true);
                    const clonedInput = clonedElement.querySelector('input');
                    const clonedLabel = clonedElement.querySelector('label');
                    const label = clonedLabel.getAttribute('for');
                    const currentLabel = label.replace('billing', 'shipping');
                    clonedLabel.setAttribute('for', currentLabel);
                    const currentName = clonedInput.name;
                    const currentId = clonedInput.id;
                    const newName = currentName.replace('billing', 'shipping');
                    const newId = currentId.replace('billing', 'shipping');
                    clonedInput.name = newName;
                    clonedInput.id = newId;

                    shippingAddressContainer.appendChild(clonedElement);


                });
                // billingLines = [];
                // original_shipping_address = {};
                const inputTag = shippingAddressContainer.querySelectorAll('input');
                inputTag.forEach((element) => {
                    element.addEventListener('change', function() {
                        if (this.checked) {
                            const checkedId = this.id;
                            original_shipping_address = {};
                            billingLines = [];
                            const labels = document.querySelector(`label[for="${checkedId}"]`);
                            const spanTags = labels.querySelectorAll('span');
                            spanTags.forEach((spanTag) => {
                                const data = spanTag.textContent;
                                billingLines.push(data);
                                original_shipping_address = {
                                    'shipping_address_1': billingLines[0],
                                    'shipping_address_2': billingLines[1],
                                    'shipping_city': billingLines[2],
                                    'shipping_zip': billingLines[5],
                                    'shipping_state': billingLines[4],
                                    'shipping_country': billingLines[3],
                                    'shipping_cost': 0.0000
                                }
                            });
                            console.log('Addressdata', original_shipping_address);
                        }
                    });
                });

                


            } else {
                const customerId = document.getElementById('customer_id');
                const id = customerId.value;
                const mannualId = id.slice(2);

                formRadio = document.createElement('div');
                formRadio.classList.add('form-radio');
                radioInput = document.createElement('input');
                radioInput.type = 'radio';
                radioInput.name = 'billing-address';
                radioInput.id = `billing-address-${mannualId}`;
                radioInput.value = `${mannualId}`;
                radioInput.checked = true;
                label = document.createElement('label');
                label.htmlFor = `billing-address-${mannualId}`;
                const addressDetails = ["billing_address_1", "billing_address_2", "billing_city",
                    "billing_country", "billing_state", "billing_zip"
                ];
                addressDetails.forEach((detailKey, index) => {
                    const span = document.createElement('span');
                    span.textContent = `${address[detailKey]}`;
                    label.appendChild(span);
                    if (index < addressDetails.length - 1) {
                        const lineBreak = document.createElement('br');
                        label.appendChild(
                        lineBreak); // Append a line break after each <span> except the last one
                    }

                });

                // span = document.createElement('span');
                // label.appendChild(span);
                formRadio.appendChild(radioInput);
                formRadio.appendChild(label);
                billingAddressContainer.appendChild(formRadio);

                if (radioInput.checked) {
                    billingLines = [];
                    original_billing_address = {};
                    original_shipping_address = {};
                    const shippingAddressDisplay = document.getElementById('shipping-address');
                    const shippingformRadioElements = shippingAddressDisplay.querySelectorAll('.form-radio');
                    shippingformRadioElements.forEach((formRadio) => {
                        // Remove each form-radio element
                        formRadio.remove();
                    });
                    const formRadio = radioInput.closest('.form-radio');
                    const spanTags = formRadio.querySelectorAll('span');
                    const shippingformRadio = document.createElement('div');
                    shippingformRadio.classList.add('form-radio');

                    spanTags.forEach((spanTag) => {
                        // const clonedSpan = spanTag.cloneNode(true);
                        // shippingformRadio.appendChild(clonedSpan);
                        const data = spanTag.textContent;
                        billingLines.push(data);
                        original_billing_address = {
                            'billing_address_1': billingLines[0],
                            'billing_address_2': billingLines[1],
                            'billing_city': billingLines[2],
                            'billing_zip': billingLines[5],
                            'billing_state': billingLines[4],
                            'billing_country': billingLines[3]
                        }

                    });
                    //   shippingAddressDisplay.appendChild(shippingformRadio);
                    console.log('original_billing_address', original_billing_address);
                }


                // console.log(`billingAddressContainer`,billingAddressContainer);

            }


                        // Trigger change event on the initially selected radio input for billing address
            const initiallySelectedBillingRadio = document.querySelector('input[name="billing-address"]:checked');
            if (initiallySelectedBillingRadio) {
                initiallySelectedBillingRadio.dispatchEvent(new Event('change'));
            }

            // Trigger change event on the initially selected radio input for shipping address
            const initiallySelectedShippingRadio = document.querySelector('input[name="shipping-address"]:checked');
            if (initiallySelectedShippingRadio) {
                initiallySelectedShippingRadio.dispatchEvent(new Event('change'));
            }



        }

    });

    // table js

    // Get all the <select> elements with the class "order-product"
    const orderProductSelects = document.querySelectorAll('.order-product');
    // Add an event listener to each <select> element
    orderProductSelects.forEach(function(select) {
        select.addEventListener('change', function() {
            // Get the selected option

            const selectedOption = this.options[this.selectedIndex];
            // Find the closest parent row element
            const row = this.closest('tr');


            // Get the adjacent quantity input
            const quantityInput = row.querySelector('.quantity');

            // Call displayPrice to update the price
            displayPrice(selectedOption, quantityInput);

        });
    });

    let sub = '';

    function updateTotal(discountamount = null) {
        const tableBody = document.getElementById('productTableBody');
        const rows = tableBody.querySelectorAll('tr');
        const t_amt = document.getElementById('total_amt');
        const total_amt = t_amt.value;
        const st_amt = document.getElementById('subtotal_amt');
        const subtotal_amt = st_amt.value;
        let total;
        let sub_total;
        if (subtotal_amt === '') {
            sub_total = 0;
        } else {
            sub_total = parseFloat(total_amt);
        }
        if (total_amt === '') {
            total = 0;
        } else {
            total = parseFloat(total_amt);
        }

        if (discountamount) {
            // Log a message when a discount is applied


            // Reduce the total by the discount amount
            total -= parseFloat(discountamount);

        }
        //    console.log('subtotal_amt',subtotal_amt);
        rows.forEach(function(row) {

            const lineTotalCell = row.querySelector('td:nth-child(4)');
            const lineTotal = parseFloat(lineTotalCell.textContent.replace('MYR ', '')) || 0;
            total += lineTotal;
            sub_total += lineTotal;
        });

        // const r = document.querySelector('tfoot .total-row td:nth-child(4) ');
        // console.log('r',r.textContent);

        // const totalFooter = document.querySelector('tfoot td:nth-child(4)');
        // totalFooter.textContent = `Total MYR ${total.toFixed(2)}`;
        const subTotalFooter = document.querySelector('tfoot .subtotal-row td:nth-child(4)');
        subTotalFooter.textContent = `MYR ${sub_total.toFixed(2)}`;
        const totalFooter = document.querySelector('tfoot .total-row td:nth-child(4)');
        totalFooter.textContent = `MYR ${total.toFixed(2)}`;
        // sub =  document.getElementById('sub_amt_coupon');
        return sub_total.toFixed(2);
        // const discountRow = document.querySelector('.discount-row');
        // const thirdtd = discountRow.querySelector('td:nth-child(3)');
        // const forthtd =  discountRow.querySelector('td:nth-child(4)');
        // const type = 'percent';
        // const discountAmount = discounted2(discount,orderAmount,type);
        // discountRow.style.display = 'table-row';
        // forthtd.textContent = '-MYR '+discountAmount;
        // thirdtd.textContent = 'coupon ['+coupon+']:';



    }

    // Function to calculate and display price when dropdown selection changes
    function displayPrice(selectedOption, quantityInput) {
        const unitPrice = selectedOption.getAttribute('data-info');
        const priceDisplay = quantityInput.parentElement.previousElementSibling;
        //  console.log('quantityInput',quantityInput);
        priceDisplay.textContent = `MYR ${unitPrice}`;
    }

    function test(tr) {
        const quantity = tr.querySelector('.quantity').value;
        const selectedOption = tr.querySelector('.order-product option:checked');
        // const csrfToken = "{{ csrf_token() }}";
        //   fetch(route('cart.items.store', {  product_id:selectedOption.value , qty: quantity  }), {
        //   fetch(route('checkout.create', {  product_id:selectedOption.value , qty: quantity  }), {
        //         method: 'POST',
        //         headers: {
        //             'Content-Type': 'application/json',
        //             'X-CSRF-TOKEN': csrfToken,
        //             // You can include other headers here if needed
        //         },
        //          })
        //         .then(response => {
        //             if (!response.ok) {
        //                 throw new Error('Network response was not ok');
        //             }
        //             return response.json();
        //         })
        //  console.log('tr',tr);
    }
    // Function to calculate line total based on quantity and unit price
    function calculateLineTotal(row) {
        const quantity = row.querySelector('.quantity').value;
        const selectedOption = row.querySelector('.order-product option:checked');
        const unitPrice = selectedOption.getAttribute('data-info');
        const lineTotal = quantity * unitPrice;
        row.querySelector('td:nth-child(4)').textContent = `MYR ${lineTotal.toFixed(2)}`;
        // const obj = {quantity:quantity,selectedOption:selectedOption,unitPrice:unitPrice,lineTotal:lineTotal} 
        updateTotal();

    }

    // Function to add a new row
    //     function addRow()
    //      {
    //     const tableBody = document.getElementById('productTableBody');
    //     const rowToClone = tableBody.querySelector('tr:first-child');
    //     const newRow = rowToClone.cloneNode(true);
    //     tableBody.appendChild(newRow);
    //     newRow.querySelector('.quantity').value = '';
    //     calculateLineTotal(newRow);
    //     updateTotal(); // Recalculate and update the total after adding a new row
    // }

    // Function to add a new row
    function addRow(addto) {
        const tableBody = document.getElementById('productTableBody');
        const rowToClone = tableBody.querySelector('tr:first-child');
        const newRow = rowToClone.cloneNode(true);
        const errorSpanQty = newRow.querySelector('td:nth-child(3) div span');
        const productSpanQty = newRow.querySelector('td:nth-child(1) div span');
        const uniqueId = 'qty_error_' + Date.now();
        const productUniqueId = 'order_products_error_' + Date.now();
        errorSpanQty.id = uniqueId;
        productSpanQty.id = productUniqueId;
        tableBody.appendChild(newRow);
        // Reset the Quantity input and Line Total
        const quantityInput = newRow.querySelector('.quantity');
        quantityInput.value = '';
        const unitPriceCell = newRow.querySelector('td:nth-child(2)');
        unitPriceCell.textContent = 'MYR 0.00';
        unitPriceCell.id = 'unitPrice' + Date.now();
        const lineTotalCell = newRow.querySelector('td:nth-child(4)');
        lineTotalCell.textContent = 'MYR 0.00';
        lineTotalCell.id = 'lineTotal' + Date.now();
        const selecOption = newRow.querySelector('td:nth-child(1)');


        // Update the Unit Price based on the selected option
        const selectElement = newRow.querySelector('.order-product');
        selectElement.selectedIndex = 0;
        selectElement.dispatchEvent(new Event('change'));


        selectElement.addEventListener('change', function() {
            const selectedOption = this.options[this.selectedIndex];
            //  console.log('selectedOption',selectedOption);
            const row = this.closest('tr');
            const unitPriceCell = row.querySelector('td:nth-child(2)');
            const quantityInput = row.querySelector('.quantity');
            displayPrice(selectedOption, quantityInput);

        });

        updateTotal(); // Recalculate and update the total after adding a new row
    }


    // Function to add a new row
    // function addRow() {
    //   const tableBody = document.getElementById('productTableBody');
    //   const rowToClone = tableBody.querySelector('tr:first-child');
    //   const newRow = rowToClone.cloneNode(true);
    //   tableBody.appendChild(newRow);

    //   // Generate a unique ID and name for the select element in the new row
    //   const selectElement = newRow.querySelector('.order-product');
    //   const uniqueId = `order_products_${tableBody.children.length}`;
    //   selectElement.id = uniqueId;
    //   selectElement.name = `order_products_${tableBody.children.length}`;

    //   // Reset the Quantity input and Line Total
    //   const quantityInput = newRow.querySelector('.quantity');
    //   quantityInput.value = '';
    //   const lineTotalCell = newRow.querySelector('td:nth-child(4)');
    //   lineTotalCell.textContent = 'MYR 0.00';

    //   // Update the Unit Price based on the selected option
    //   const selectedOption = newRow.querySelector('.order-product option:checked');
    //   displayPrice(selectedOption, quantityInput);

    //   updateTotal(); // Recalculate and update the total after adding a new row
    // }



    // Function to delete a row
    function deleteRow(button) {
        const tableBody = document.getElementById('productTableBody');
        if (tableBody.rows.length > 1) {
            const row = button.parentElement.parentElement;
            tableBody.removeChild(row);
        }
    }

    // Add button click event
    document.getElementById('productTableBody').addEventListener('click', function(event) {
        event.preventDefault();
        if (event.target.classList.contains('add-row')) {
            addRow(this, event.target);
        } else if (event.target.classList.contains('delete-row')) {
            deleteRow(event.target);
            updateTotal();
            add_couponData()
            // Recalculate and update the total after deleting a row
        }
    });

    function add_couponData() {
        const is_present = sub.is_percent;
        const orderAmount = updateTotal();
        const type = 'percent';
        //   console.log('is_present',is_present);
        if (is_present && updateTotal() > 0) {
            const valid = handleCouponValidation(sub, orderAmount);
            const discountRow = document.querySelector('.discount-row');

            if (valid) {
                discountRow.style.display = "none";
                discountRow.querySelector('td:nth-child(3)').textContent = '';
                discountRow.querySelector('td:nth-child(4)').textContent = '';
            }

            if (valid == 'coupon is valid') {
                const discount = sub.value;
                const discountAmount = discounted(discount, orderAmount, type);
                discountRow.style.display = 'table-row';
                const thirdtd = discountRow.querySelector('td:nth-child(3)');
                const forthtd = discountRow.querySelector('td:nth-child(4)');
                forthtd.textContent = '-MYR ' + discountAmount;
                thirdtd.textContent = 'coupon [' + sub.code + ']:';
                const errorElement = document.getElementById('coupon_error');
                errorElement.textContent = valid;
                const couponElement = document.getElementById('coupon');
                couponElement.value = sub.code;
                return valid;
            }
            const errorElement = document.getElementById('coupon_error');
            errorElement.textContent = valid;
            const couponElement = document.getElementById('coupon');
            return valid;



        }
    }

    // Calculate line total when quantity changes
    document.getElementById('productTableBody').addEventListener('input', function(event) {
        if (event.target.classList.contains('quantity')) {
            test(event.target.parentElement.parentElement);
            calculateLineTotal(event.target.parentElement.parentElement);
            add_couponData();


        }
    });
    const productArray = [];
    // function CollectProductData(button) {
    //         event.preventDefault();

    //         const row = button.parentElement.parentElement;
    //         const p_id = row.querySelector('.order-product').value;
    //         const unit_price = row.querySelector('td:nth-child(2)').textContent.split(' ')[1];
    //         const line_total = row.querySelector('td:nth-child(4)').textContent.split(' ')[1];
    //         const qty = row.querySelector('.quantity').value;
    //         const product = {
    //             product_id:p_id,
    //             unit_price:unit_price, 
    //             qty:qty,
    //             line_total:line_total,

    //         }
    //         productArray.push(product);
    //         console.log('productArray',productArray);


    // }
    function displayErrorMessage(fieldId, message,spanId) {
        let spanError = '';
        if(spanId){
             spanError = '_'+spanId;
           
        }
        else{
            spanError = '';
        }
        
        const errorElement = document.getElementById(fieldId + '_error'+spanError);
        errorElement.textContent = message;
        errorElement.style.color = 'red';

    }

    function isValidEmail(email) {
        const emailRegex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;
        return emailRegex.test(email);
    }

    function isValidPhoneNumber(phoneNumber) {
        // This regex matches Malaysian phone number formats:
        // 012-3456789, 012-345 6789, +6012-345 6789, +60123456789, 0123456789, 0123 456 789
        const phoneRegex = /^(?:(?:\+?6?01)[-. ]?)?(\d{3,4})[-. ]?(\d{3})[-. ]?(\d{4})$/;
        return phoneRegex.test(phoneNumber);
    }

    function validateForm(row) {
        const emailInput = document.getElementById('customer_email');
        const phoneInput = document.getElementById('customer_phone');
        const paymentSelect = document.getElementById('payment_method');
        const nameSelect = document.getElementById('user');
        const statusSelect = document.getElementById('status');
        const productSelect = document.getElementById('order_products');
        const productQty =  row.querySelector('.quantity');
        const emailValue = emailInput.value.trim();
        const phoneValue = phoneInput.value.trim();
        const paymentValue = paymentSelect.value;
        const statusValue = statusSelect.value;
        const nameValue = nameSelect.value;
        const productValue = productSelect.value;
        const qtyValue = productQty.value;
        let isValid = true;
        const spanId = row.querySelector('td:nth-child(3) div span');
        const  productSpan = row.querySelector('td:nth-child(1) div span');
        console.log('productSpan',productSpan);
        const  qtyError = spanId.id.split('_');

        if (emailValue === '') {
            displayErrorMessage('email', 'The email field is required.');
            isValid = false;
        } else if (!isValidEmail(emailValue)) {

            displayErrorMessage('email', 'Email is not valid');
            isValid = false;


        }

        if (phoneValue === '') {
            displayErrorMessage('phone', 'The phone number field is required.');
            isValid = false;
        } else if (!isValidPhoneNumber(phoneValue)) {
            displayErrorMessage('phone', 'Phone number is not valid');
            isValid = false;
        }

        if (paymentValue == 0) {

            displayErrorMessage('payment_method', 'The Payment Method  field is required.');
            isValid = false;

        }

        if (statusValue == 0) {

            displayErrorMessage('status', 'The Order Status  field is required.');
            isValid = false;

        }

        if (nameValue == 0) {

            displayErrorMessage('user', 'The Customer Name  field is required.');
            isValid = false;

        }
        if (productValue == 0) {

            displayErrorMessage('order_products', 'The Product  field is required.');
            isValid = false;

        }
        if (qtyValue === '') {
            displayErrorMessage('qty', 'The Quantity  field is required.',qtyError[2]);
            isValid = false;

        }
        return isValid;
    }

    function handleCouponValidation(coupon, orderAmount) {
        // if(coupon.maximum_spend){
        //     return 'coupon maximum_spend exists.';
        // }else{
        //     return 'coupon maximum_spend doest exists.';
        // }

        try {
            // Check if the coupon code is missing or empty
            if (!coupon || !coupon.code) {
                throw new Error('The coupon does not exist.');
            }

            // Check if the coupon has expired
            const currentDate = new Date();
            const endDate = new Date(coupon.end_date);

            if (currentDate > endDate) {
                throw new Error('Coupon has expired');
            }

            // Check if the coupon is used up
            if (coupon.usageLimitpercoupon) {
                throw new Error('Coupon has been fully used');
            }

            // Check if the order amount is below the minimum spend
            // const orderAmount =  orderAmount /* Get the order amount from your application */;
            if (coupon.didNotSpendTheRequiredAmount) {
                const minimumSpend = parseFloat(coupon.minimum_spend.amount);

                if (orderAmount < minimumSpend) {
                    throw new Error(`Order amount must be at least ${coupon.minimum_spend.formatted}`);
                }

            }

            if (coupon.maximum_spend) {
                // Check if the order amount exceeds the maximum spend
                const maximumSpend = parseFloat(coupon.maximum_spend.amount);

                if (orderAmount > maximumSpend) {
                    throw new Error(`Order amount cannot exceed ${coupon.maximum_spend.formatted}`);
                }
            }


            // Check if the customer has exceeded the usage limit
            const usageLimitPerCustomer = coupon.usage_limit_per_customer;

            if (coupon.usageLimitpercoupon !== false && coupon.used >= usage_limit_per_coupon) {
                throw new Error(`Customer has exceeded the usage limit for this coupon`);
            }

            // Add more custom checks here based on your requirements

            // Check if the coupon has already applied
            const alreadyApplied = coupon.alreadyapplied;

            if (alreadyApplied) {
                throw new error('The coupon has been already applied.');
            }

            const invalid = coupon.invalid;

            if (invalid) {
                throw new error('The coupon is not valid.');
            }



            // If all checks pass, you can return a success message
            return 'coupon is valid';

        } catch (error) {
            // Handle and log the error or return an error message
            return `Error: ${error.message}`;
        }

    }


    function discounted(discount = '', orderAmount = null, type = '') {
        const amount = parseFloat(orderAmount);
        if (type == 'percent') {

            // Parse the discount and orderAmount strings as floats
            const discountPercentage = parseFloat(discount);


            if (!isNaN(discountPercentage) && !isNaN(amount)) {
                // Calculate the discounted amount
                const discountAmount = (discountPercentage / 100) * amount;
                const discountedAmount = amount - discountAmount;

                // Return the discounted amount as a string with 2 decimal places
                updateTotal(discountedAmount.toFixed(2));
                return discountedAmount.toFixed(2);
            } else {
                // Handle invalid input (e.g., non-numeric values)
                return 'Invalid input';
            }

        } else {
            const discountAmount = amount - discount;
            // updateTotal(discountAmount.toFixed(2));
            updateTotal(discount.toFixed(2));
            console.log('discountAmount', discountAmount);
            return discount.toFixed(2);

        }


    }

    //submit coupon click event
    document.getElementById('coupon_btn').addEventListener('click', function() {
        event.preventDefault();
        sum = '';
        const couponElement = document.getElementById('coupon');
        const coupon = couponElement.value;
        const csrfToken = "{{ csrf_token() }}";

        // const url = `/cart/coupon?coupon=${encodeURIComponent(coupon)}`;;

        if (coupon == '') {
            const msg = 'The coupon does not exist.';
            return false;
        }




        fetch(route('cart.coupon.store', {
                coupon: coupon,
                type: 'manual'
            }), {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'X-CSRF-TOKEN': csrfToken,
                    // You can include other headers here if needed
                },
            })
            .then(response => response.json())
            .then(data => {
                const couponObject = data.coupon;
                const rows = document.querySelectorAll('.subtotal-row');
                var orderAmount = 0;
                rows.forEach(function(row) {
                    orderAmount = row.querySelector('td:nth-child(4)').textContent.split('MYR')[1]
                        .trim();
                });
                console.log('couponObject', couponObject);

                const errorElement = document.getElementById('coupon_error');
                const discountRow = document.querySelector('.discount-row');
                const validationMessage = handleCouponValidation(couponObject, orderAmount);
                const discount_amt = document.getElementById('discount_amt');
                const is_percent = document.getElementById('discount_type');
                const coupon_id = document.getElementById('coupon_id');
                if (validationMessage) {
                    discountRow.style.display = "none";
                    discountRow.querySelector('td:nth-child(3)').textContent = '';
                    discountRow.querySelector('td:nth-child(4)').textContent = '';
                }
                const thirdtd = discountRow.querySelector('td:nth-child(3)');
                const forthtd = discountRow.querySelector('td:nth-child(4)');
                errorElement.textContent = validationMessage;
                errorElement.style.color = 'red';
                if (validationMessage == 'coupon is valid') {
                    const discount = couponObject.value;
                    const discount_type = couponObject.is_percent;
                    coupon_id.value = couponObject.id;
                    is_percent.value = discount_type;
                    discount_amt.value = discount;

                    if (discount_type == 1) {
                        sub = couponObject;

                        const type = 'percent';
                        const discountAmount = discounted(discount, orderAmount, type);
                        discountRow.style.display = 'table-row';
                        forthtd.textContent = '-MYR ' + discountAmount;
                        thirdtd.textContent = 'coupon [' + coupon + ']:';


                    } else {
                        const dis = discount.inCurrentCurrency.amount;
                        discount_amt.value = dis;
                        const type = 'fixed';
                        const discountAmount = discounted(dis, orderAmount, type);
                        discountRow.style.display = 'table-row';
                        forthtd.textContent = '-MYR ' + discountAmount;
                        thirdtd.textContent = 'coupon [' + coupon + ']:';
                    };
                }

            });



        // fetch(route('admin.orders.coupontest'), {
        //     method: 'GET',
        //     headers: {
        //         'Content-Type': 'application/json',
        //         'X-CSRF-TOKEN': csrfToken,
        //         // You can include other headers here if needed
        //     },
        //      })
        //     .then(response => {
        //         if (!response.ok) {
        //             throw new Error('Network response was not ok');
        //         }
        //         return response.json();
        //     })



    });
    // Submit button click event

    document.addEventListener('DOMContentLoaded', function() {
        updateTotal();
        const editFormButton = document.getElementById('editForm');
        const submitFormButton = document.getElementById('submitForm');
        if (editFormButton) {

            document.getElementById('editForm').addEventListener('click', function(event) {
                event.preventDefault();
                const order_id = document.getElementById('order_id');
                const id = order_id.value;
                const selectedProducts = [];
                const rows = document.querySelectorAll('#productTableBody tr');
                rows.forEach(function(row) {
                    // const unit_price = row.querySelector('td:nth-child(2)').textContent.split(' ')[1];
                    // const line_total = row.querySelector('td:nth-child(4)').textContent.split(' ')[1];
                    const unit_price = row.querySelector('td:nth-child(2)').textContent.split(
                        'MYR')[1].trim();
                    const line_total = row.querySelector('td:nth-child(4)').textContent.split(
                        'MYR')[1].trim();
                    const product_id = row.querySelector('select').value;

                    const product = {
                        product_id: product_id,
                        unit_price: unit_price,
                        qty: row.querySelector('.quantity').value,
                        line_total: line_total,

                    };
                    selectedProducts.push(product);

                });

                const formElements = [];
                const form = document.getElementById('order_create_form');
                const allInputsAndSelects = form.querySelectorAll('input,select');
                const formValues = {};
                // Create an object to store the form values



                allInputsAndSelects.forEach((element) => {
                    let isInsideTable = false;
                    let parentElement = element.parentElement;

                    while (parentElement) {
                        if (parentElement.tagName === 'TABLE') {
                            isInsideTable = true;
                            break;
                        }
                        parentElement = parentElement.parentElement;
                    }

                    if (!isInsideTable) {
                        formElements.push(element);
                    }
                });


                formElements.forEach(function(element) {
                    const name = element.name;
                    const value = element.value;

                    // Check if the element has a name attribute
                    if (name) {
                        formValues[name] = value;
                    }
                    if (name == 'user') {
                        const selectedOption = element.options[element.selectedIndex];
                        const fullname = selectedOption.textContent.split(' ');

                        formValues['customer_first_name'] = fullname[0];
                        formValues['customer_last_name'] = fullname[1];
                        formValues['billing_first_name'] = fullname[0];
                        formValues['billing_last_name'] = fullname[1];
                        formValues['shipping_first_name'] = fullname[0];
                        formValues['shipping_last_name'] = fullname[1];

                    }
                    if (name == "customer_id") {

                        const customer_id = value.split('-')[1];
                        formValues[name] = customer_id;


                    }

                });

                // Select the billing address label and span elements
                const billingLabel = document.querySelector('label[for="billing-address_input"]');
                const billingSpan = billingLabel.querySelector('span');

                // Extract the text content from the label and split it by line breaks
                const billingLines = billingSpan.textContent.trim().split('\n');

                for (const key in billingLines) {
                    if (Object.hasOwnProperty.call(billingLines, key) && typeof billingLines[key] ===
                        'string') {
                        billingLines[key] = billingLines[key].trim();
                    }
                }
                const billingfilteredData = billingLines.filter(item => item.trim() !== "");

                // Create a JavaScript object with keys and values
                const billingData = {
                    'billing_address_1': billingfilteredData[0],
                    'billing_address_2': billingfilteredData[1],
                    'billing_city': billingfilteredData[2],
                    'billing_zip': billingfilteredData[3],
                    'billing_state': billingfilteredData[4],
                    'billing_country': billingfilteredData[5]
                };

                // Select the billing address label and span elements
                const shippingLabel = document.querySelector('label[for="shipping-address_input"]');
                const shippingSpan = shippingLabel.querySelector('span');

                // Extract the text content from the label and split it by line breaks
                const shippingLines = shippingSpan.textContent.trim().split('\n');

                for (const key in shippingLines) {
                    if (Object.hasOwnProperty.call(shippingLines, key) && typeof shippingLines[key] ===
                        'string') {
                        shippingLines[key] = shippingLines[key].trim();
                    }
                }
                const shippingfilteredData = shippingLines.filter(item => item.trim() !== "");


                // Create a JavaScript object with keys and values for shipping data
                const shippingData = {
                    'shipping_address_1': shippingfilteredData[0].trim(),
                    'shipping_address_2': shippingfilteredData[1].trim(),
                    'shipping_city': shippingfilteredData[2].trim(),
                    'shipping_zip': shippingfilteredData[3].trim(),
                    'shipping_state': shippingfilteredData[4].trim(),
                    'shipping_country': shippingfilteredData[5].trim(),
                    'shipping_cost': 0.0000
                };

                // const  mergedObj = { ...formValues, ...billingData, ...shippingData, ...selectedProducts };
                //     let merged ={};
                // selectedProducts.forEach((obj) => {
                //     data = { ...mergedObj, ...obj };
                //     });

                const totalammount = document.querySelector('tfoot td:nth-child(4)').textContent;
                const total_a = totalammount.split(' ')[2];
                const subtotalammount = document.querySelector('tfoot td:nth-child(4)').textContent;
                const subtotal_a = subtotalammount.split(' ')[2];
                const csrfToken = "{{ csrf_token() }}";

                const data = {
                    ...formValues,
                    ...billingData,
                    ...shippingData,
                    total: total_a,
                    sub_total: subtotal_a,
                    discount: 0.0000,
                    currency: 'MYR',
                    currency_rate: 1000,
                    locale: 'en',
                    user_type: user_typeInput.value
                };
                delete data.user;
                delete data.order_id;
                delete data.total_amt;

                for (const key in data) {
                    if (Object.hasOwnProperty.call(data, key) && typeof data[key] === 'string') {
                        data[key] = data[key].trim();
                    }
                }


                fetch(route('admin.orders.update', id), {
                        method: 'PUT',
                        headers: {
                            'Content-Type': 'application/json',
                            'X-CSRF-TOKEN': csrfToken, // You should define 'csrfToken' or remove if not needed
                        },
                        body: JSON.stringify({
                            data: data,
                            product: selectedProducts,
                        }), // Replace 'yourDataHere' with your actual data
                    })
                    .then(response => response.json())
                    .then(data => {

                            if (data.data === 'success') {
                                // Redirect to the list page
                                window.location.href = route(
                                "admin.orders.index"); // Replace with the actual URL

                                //  console.log('data',data.data); 
                            }

                        }

                    );




            });

        }
        function validateAllRows()
        {
            let isValid = true;
            const rows = document.querySelectorAll('#productTableBody tr');
            rows.forEach(function(row){
                if(!validateForm(row)){
                    isValid = false;
                }
                
            });
            return isValid;
           
        }
       
        if (submitFormButton) {
            
            document.getElementById('submitForm').addEventListener('click', function(event) {
                event.preventDefault();
                // validateAllRows();
                if (!validateAllRows()) {
                    event.preventDefault();
                } else {
                    const selectedProducts = [];
                    const rows = document.querySelectorAll('#productTableBody tr');
                    rows.forEach(function(row) {
                        const unit_price = row.querySelector('td:nth-child(2)').textContent
                            .split(' ')[1];
                        const line_total = row.querySelector('td:nth-child(4)').textContent
                            .split(' ')[1];
                        const product = {
                            product_id: row.querySelector('.order-product').value,
                            unit_price: unit_price,
                            qty: row.querySelector('.quantity').value,
                            line_total: line_total,

                        };
                        selectedProducts.push(product);
                    });
                    const formElements = [];
                    const form = document.getElementById('order_create_form');
                    const allInputsAndSelects = form.querySelectorAll('input,select');
                    const formValues = {};
                    // Create an object to store the form values



                    allInputsAndSelects.forEach((element) => {
                        let isInsideTable = false;
                        let parentElement = element.parentElement;

                        while (parentElement) {
                            if (parentElement.tagName === 'TABLE') {
                                isInsideTable = true;
                                break;
                            }
                            parentElement = parentElement.parentElement;
                        }

                        if (!isInsideTable) {
                            formElements.push(element);
                        }
                    });


                    formElements.forEach(function(element) {
                        const name = element.name;
                        const value = element.value;

                        // Check if the element has a name attribute
                        if (name) {
                            formValues[name] = value;
                        }
                        if (name == 'user') {
                            const selectedOption = element.options[element.selectedIndex];
                            const fullname = selectedOption.textContent.split(' ');

                            formValues['customer_first_name'] = fullname[0];
                            formValues['customer_last_name'] = fullname[1];
                            formValues['billing_first_name'] = fullname[0];
                            formValues['billing_last_name'] = fullname[1];
                            formValues['shipping_first_name'] = fullname[0];
                            formValues['shipping_last_name'] = fullname[1];

                        }
                        if (name == "customer_id") {

                            const customer_id = value.split('-')[1];
                            formValues[name] = customer_id;


                        }

                    });

                    function isEmpty(obj) {
                        return Object.keys(obj).length === 0;
                    }
                    // const other_addres = other_address.getElementById('other_address');
                    const other = other_address.querySelector('input')
                    other.addEventListener('change', function() {
                        if (this.checked) {

                            console.log('shipping_address');

                        }
                    });

                    console.log('submitbutton', original_billing_address, original_shipping_address);
                    if (isEmpty(original_shipping_address) && !isEmpty(original_billing_address)) {
                        original_shipping_address['shipping_address_1'] = original_billing_address
                            .billing_address_1;
                        original_shipping_address['shipping_address_2'] = original_billing_address
                            .billing_address_2;
                        original_shipping_address['shipping_city'] = original_billing_address
                            .billing_city;
                        original_shipping_address['shipping_country'] = original_billing_address
                            .billing_country;
                        original_shipping_address['shipping_state'] = original_billing_address
                            .billing_state;
                        original_shipping_address['shipping_zip'] = original_billing_address
                        .billing_zip;


                    }
                    console.log('original_billing_address', original_billing_address);
                    console.log('original_shipping_address', original_shipping_address);

                    const discountTag = document.querySelector('tfoot .discount-row td:nth-child(4)');
                    const sliceText = discountTag.textContent.split(' ');
                    let discount = sliceText[1];
                    if (discount == 'MYR:' || discount == '' || discount == undefined) {
                        discount = 0.0000;

                    }
                    // console.log('discount',discount);


                    // // Select the billing address label and span elements
                    // const billingLabel = document.querySelector('label[for="billing-address_input"]');
                    // const billingSpan = billingLabel.querySelector('span');

                    // // Extract the text content from the label and split it by line breaks
                    // const billingLines = billingSpan.textContent.trim().split('\n');

                    // // Create a JavaScript object with keys and values
                    // const billingData = {
                    // 'billing_address_1': billingLines[0],
                    // 'billing_address_2': billingLines[1],
                    // 'billing_city': billingLines[2],
                    // 'billing_zip': billingLines[3],
                    // 'billing_state': billingLines[4],
                    // 'billing_country': billingLines[5]
                    // };

                    //  // Select the billing address label and span elements
                    //  const shippingLabel = document.querySelector('label[for="shipping-address_input"]');
                    // const shippingSpan = billingLabel.querySelector('span');

                    // // Extract the text content from the label and split it by line breaks
                    // const shippingLines = shippingSpan.textContent.trim().split('\n');

                    // // Create a JavaScript object with keys and values
                    // const shippingData = {
                    // 'shipping_address_1': shippingLines[0],
                    // 'shipping_address_2': shippingLines[1],
                    // 'shipping_city': shippingLines[2],
                    // 'shipping_zip': shippingLines[3],
                    // 'shipping_state': shippingLines[4],
                    // 'shipping_country': shippingLines[5],
                    // 'shipping_cost':0.0000
                    // };

                    // const  mergedObj = { ...formValues, ...billingData, ...shippingData, ...selectedProducts };
                    //     let merged ={};
                    // selectedProducts.forEach((obj) => {
                    //     data = { ...mergedObj, ...obj };
                    //     });

                    const totalammount = document.querySelector('tfoot .total-row td:nth-child(4)')
                        .textContent;
                    const parts = totalammount.split(' ');
                    const currency = parts[0];
                    const total_a = parts[1];
                    const subtotalammount = document.querySelector(
                        'tfoot .subtotal-row td:nth-child(4)').textContent;
                    const subtotal_a = subtotalammount.split(' ')[1];

                    const couponTag = document.getElementById('coupon_id');
                    //    console.log('coupon_id',coupon_id.value);
                    const coupon_id = couponTag.value;
                    const csrfToken = "{{ csrf_token() }}";

                    const data = {
                        ...formValues,
                        ...original_billing_address,
                        ...original_shipping_address,
                        total: total_a,
                        sub_total: subtotal_a,
                        discount: discount,
                        currency: currency,
                        currency_rate: 1000,
                        locale: 'en',
                        user_type: user_typeInput.value,
                        shipping_cost: 0.0000,
                        coupon_id: coupon_id
                    };
                    delete data.user;
                    delete data.order_id;
                    delete data.total_amt;
                    delete data.subtotal_amt;
                    delete data.discount_amt;
                    delete discount_type;
                    delete data.discount_type;
                    delete data.sub_amt_coupon;
                    delete data['billing-address'];
                    delete data['other_address'];
                    delete data['shipping-address'];
                    console.log('data', data);
                //  return;

                    fetch(route("admin.orders.store"), {
                            method: 'POST',
                            headers: {
                                'Content-Type': 'application/json',
                                'X-CSRF-TOKEN': csrfToken, // You should define 'csrfToken' or remove if not needed
                            },
                            body: JSON.stringify({
                                data: data,
                                product: selectedProducts
                            }), // Replace 'yourDataHere' with your actual data
                        })
                        .then(response => response.json())
                        .then(data => {

                                if (data.data === 'success') {
                                    // Redirect to the list page
                                    window.location.href = route(
                                    "admin.orders.index"); // Replace with the actual URL
                                }

                            }

                        );

                    //   console.log('billingData',shippingData);

                }
                // Now you have an array of selected products to send to the server via AJAX or form submission.


            });

        }
    });
</script>
