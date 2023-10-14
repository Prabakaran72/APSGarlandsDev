@extends('admin::layout')

@component('admin::components.page.header')
    @slot('title', trans('admin::resource.create', ['resource' => trans('email::emails.email')]))

    <li><a href="{{ route('admin.emails.index') }}">{{ trans('email::emails.emails') }}</a></li>
    <li class="active">{{ trans('admin::resource.create', ['resource' => trans('email::emails.email')]) }}</li>
@endcomponent

@section('content')
    <div class='accordion-content clearfix'>
        <div class='col-lg-12'>
            <form method="POST" action="{{ route('admin.emails.stores') }}" class="form-horizontal" id="email-create-form" novalidate>
                {{ csrf_field() }}

                <div class="form-group">
                    <div class="col-md-2">
                        <strong>Subscribers *</strong>  
                        <p><small class='text-blue'>@ Select Multiple Data</small></p>      
                        <p><small class='text-blue'>[ Mac :: cmd + Select ]</small></p>      
                        <p><small class='text-blue'>[ Windows :: ctrl + Select ]</small></p>          
                    </div>
                    <div class="col-md-10">
                        <select name='subscribers[]' id="subscribers" class='form-control' multiple="multiple">
                            <option value="selectAll" id="select-all">{{ "Select All" }}</option>    
                            @foreach ($subscribers as $subscriber)
                                <option value="{{ $subscriber->email }}">{{ $subscriber->email }}</option>             
                            @endforeach
                        </select>    
                    </div>
                </div>        

                <div class="form-group">
                    <div class="col-md-2">
                        <strong>Subject *</strong>        
                    </div>
                    <div class="col-md-10">
                        <input type='text' name='subject' class='form-control'></input>                                
                    </div>
                </div>

                <div class="form-group">
                    <div class="col-md-2">
                        <strong>Template *</strong>        
                    </div>
                    <div class="col-md-10">
                        <select name='template' class='form-control'>
                            @foreach ($templates as $template)
                                <option value="{{ $template->slug }}">{{ $template->slug }}</option>             
                            @endforeach
                        </select>        
                    </div>
                </div>

                <div class="form-group">
                    <div class="col-md-2">
                        <strong>Schedule *</strong>        
                    </div>
                    <div class="col-md-10">
                        <input name='is_active' type='checkbox' class='schedule-checkbox'></input>   
                        <label>Enable</label>         
                    </div>
                </div>    

                <div class="form-group">
                    <div class="col-md-2">
                        <strong>Date *</strong>        
                    </div>
                    <div class="col-md-10">
                        <input type='datetime-local' id="custom-date-time" name='date' class='form-control'></input>        
                    </div>
                </div>

                    

                <button class='btn btn-primary' type='submit' >Save</button>
                <!-- <button class='btn btn-success' id='send'>Send Now</button> -->
            </form>

            @if($errors->any())
                        <div class="alert alert-danger">
                            <ul>
                                @foreach ($errors->all() as $error)
                                    <li>{{ $error }}</li>
                                @endforeach
                            </ul>
                        </div>
                    @endif
        </div>
    </div>



 

    <script> // this is for select
        document.getElementById("select-all").addEventListener("click", function (e) {
            e.preventDefault(); // Prevent the "Select All" option from being selected
            let subscribersSelect = document.getElementById("subscribers");

            // Loop through the options and select/deselect them, excluding "Select All"
            for (let option of subscribersSelect.options) {
                if (option.value !== "selectAll") {
                    option.selected = true;
                }
            }
            
            // Deselect the "Select All" option itself
            this.selected = false;
        });
    </script>

    <!-- <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function () {
            $('.schedule-checkbox').on('change', function () {
                if ($(this).prop('checked')) {
                    $('input[name="date"]').prop('disabled', false);
                    $('button[type="submit"]').prop('disabled', false);
                    $('button[id="send"]').prop('disabled', true);
                } else {
                    $('input[name="date"]').prop('disabled', true);
                    $('button[type="submit"]').prop('disabled', true);
                    $('button[id="send"]').prop('disabled', false);
                }
            });
        });
    </script> -->

    
@endsection

@include('email::admin.emails.partials.shortcuts')
