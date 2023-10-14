@extends('admin::layout')

@component('admin::components.page.header')
    @slot('title', trans('admin::resource.edit', ['resource' => trans('email::emails.email')]))   

   
    <li><a href="{{ route('admin.emails.index') }}">{{ trans('email::emails.emails') }}</a></li>
    <li class="active">{{ trans('admin::resource.edit', ['resource' => trans('email::emails.email')]) }}</li>
@endcomponent

@section('content')
    <div class='accordion-content clearfix'>
        <div class='col-lg-12'>
            <form method="POST" action="{{ route('admin.emails.updates', $email->id) }}" class="form-horizontal" id="email-edit-form" >
                {{ csrf_field() }}
                {{ method_field('put') }}

               

            
                <div class="form-group">
                    <div class="col-md-2">
                        <strong>Subscribers *</strong>  
                        <p><small class='text-blue'>@ Select Multiple Data</small></p>      
                        <p><small class='text-blue'>[ Mac :: cmd + Select ]</small></p>      
                        <p><small class='text-blue'>[ Windows :: ctrl + Select ]</small></p>      
                    </div>
                    <div class="col-md-10">
                        <select name='subscribers[]' id="subscribers" class='form-control custom-select-black' multiple="multiple">
                            <option value="selectAll" {{ in_array("all", json_decode($email->subscribers, true)) ? 'selected' : '' }}>{{ "Select All" }}</option>        
                            @foreach ($subscribers as $subscriber)
                                <option value="{{ $subscriber->email }}" {{in_array($subscriber->email, json_decode($email->subscribers, true)) ? 'selected' : ''}} >{{ $subscriber->email }}</option>             
                            @endforeach
                        </select>    
                    </div> 
                </div>     
                

                <div class="form-group">
                    <div class="col-md-2">
                        <strong>Subject *</strong>        
                    </div>
                    <div class="col-md-10">
                        <input type='text' name='subject' class='form-control' value="{{ $email->subject }}"></input>        
                    </div>
                </div>

                <div class="form-group">
                    <div class="col-md-2">
                        <strong>Template *</strong>        
                    </div>
                    <div class="col-md-10">
                        <select name='template' class='form-control'>
                                  
                            @foreach ($templates as $template)                            
                                <option value="{{ $template->slug }}" {{ $template->slug === $email->template ? 'selected' : '' }} >{{ $template->slug }}</option>             
                            @endforeach
                        </select>        
                    </div>
                </div>

                <div class="form-group">
                    <div class="col-md-2">
                        <strong>Schedule *</strong>        
                    </div>
                    <div class="col-md-10">
                        <input name='is_active' id='is_active' type='checkbox' class='schedule-checkbox' {{ ($email->is_active == 1) ? 'checked' : '' }}></input>    
                        <label>Enable</label>    
                    </div>
                </div>                

                <div class="form-group">
                    <div class="col-md-2">
                        <strong>Date *</strong>        
                    </div>
                    <div class="col-md-10">
                        <input type='date' name='date' id='data' class='form-control' value="{{ $email->date !== null ? $email->date : '' }}"></input>        
                    </div>
                </div>
                
                <button class='btn btn-primary' type='submit'>Save</button>    
                <!-- <button class='btn btn-success' id='send'>Send Now</button>                    -->
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


    <script>
        document.getElementById("subscribers").addEventListener("change", function () {
            if (this.value === "selectAll") {
                // Deselect the "Select All" option
                this.querySelector('option[value="selectAll"]').selected = false;

                // Select all options except the "Select All" option
                Array.from(this.options).forEach(function (option) {
                    if (option.value !== "selectAll") {
                        option.selected = true;
                    }
                });
            }
        });

        var isActive = document.getElementById('is_active');
        var date = document.getElementById('date');
        var saveBtn = document.getElementById('save_btn');

        if(isActive == 1) {
            date.disabled = false;
        }
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
