<?php

namespace Modules\Email\Http\Controllers\Admin;

use Modules\Email\Entities\Email;
use Modules\Template\Entities\Template;
use Modules\Template\Entities\TemplateTranslation;
use Modules\Subscriber\Entities\Subscriber;
use Modules\Admin\Traits\HasCrudActions;
use Modules\Email\Http\Requests\SaveEmailRequest;
use Illuminate\Support\Facades\DB;
use Illuminate\Http\Request;
use Illuminate\Http\Response;

class EmailController
{
    use HasCrudActions;

    public $newTemp;

    /**
     * Model for the resource.
     *
     * @var string
     */
    protected $model = Email::class;

    /**
     * Label of the resource.
     *
     * @var string
     */
    protected $label = 'email::emails.email';

    /**
     * View path of the resource.
     *
     * @var string
     */
    protected $viewPath = 'email::admin.emails';

    /**
     * Form requests for the resource.
     *
     * @var array|string
     */
    protected $validation = SaveEmailRequest::class;

    // Data get
    public function edit($id)
    {
        
        // $email = Email::find($id)->subscriber();
        $templates = Template::all();        
        $subscribers = Subscriber::all();
        $templateTranslation = TemplateTranslation::all(); 
        $email=Email::find($id);
        $getSubscriber = [];
        $getTemplate = [];

        
        // This forLoop for Template
            foreach ($templates as $template) {
                $getTemplate[] = $template->slug;                                               
            }

        // This forLoop for Subscriber
            foreach($subscribers as $subscriber) {
                $getSubscriber[] = $subscriber->email;
            }

       
        return view("{$this->viewPath}.edit", compact('email','subscribers','templates','templateTranslation'));
    }



    public function create()
    {
        $templates = Template::all();
        $templateTranslation = TemplateTranslation::all();        
        $subscribers = Subscriber::all();
        $email=Email::get(); 

        $this->newTemp = $templateTranslation;

        $getSubscriber = [];
        $getTemplate = [];
        
        // dd($templateTranslation);
       
        // This forLoop for Template
        foreach ($templates as $template) {
            $getTemplate[] = $template->slug;                                               
        }

        // This forLoop for Subscriber
        foreach($subscribers as $subscriber) {
            $getSubscriber[] = $subscriber->email;
        }

        return view("{$this->viewPath}.create", compact('email','subscribers','templates','templateTranslation'));
        
    }


    public function store(Request $request) {
       
        // Assuming you have this code to retrieve and store the 'is_active' value
        $is_active = isset($request->is_active) ? 1 : 0;   
        $subscribers = $request->input('subscribers');     
        $id = $request->input('template');        
        $getTemplate = TemplateTranslation::find($id);

        $body = $getTemplate->body;
        $body = str_replace('<img src="', '<img src="'.env('APP_URL'), $body);
        
        $htmlContent = "<html>";
        $htmlContent .= "<body>";
        $htmlContent .= $body;
        $htmlContent .= "</body>";
        $htmlContent .= "<html>";
        $fromName = env('MAIL_FROM_NAME');
        
        
        
        $email = new Email();        
        $email->subscribers = json_encode($request->input('subscribers'));
        $email->subject = $request->input('subject');
        $email->template = $getTemplate->name;
        $email->date = $request->input('date');
        $email->is_active = $is_active;        
              
        // Validate the request
        $request->validate([
            'subscribers' => 'required|array|min:1',
            'subject' => 'required',
            'template' => 'required',            
        ]);
        $email->save();



                
        // ***  SEND MAIL  *** //
        // $to = env('MAIL_USERNAME');                
        $fromEmail = 'ashik@santhila.co'; // Set the common "Reply-To" address
        $subject = $email->subject; 
        $message = $htmlContent;
        $headers = "MIME-Version: 1.0" . "\r\n"; 
        $headers .= "Content-type:text/html;charset=UTF-8" . "\r\n"; 
        $headers .= 'From: ' . $fromName . "\r\n" . 
        'Reply-To: ' . $fromEmail . "\r\n" . 
        'X-Mailer: PHP/' . phpversion();
        foreach ($subscribers as $subscriber) {
            $to = $subscriber; // Set the recipient's email address for this iteration
           mail($to, $subject, $message, $headers);
        }
        

  
        if ($email->id) {
            session()->flash('success', 'Email created successfully');            
            return redirect('admin/emails');
        } else {
            return back()->withInput()->withErrors(['error' => 'Email creation failed.']);
        }
        
    }


    public function update(Request $request, $id) {

        $email = Email::find($id);   
        $subscribers = $request->input('subscribers');           
        $is_active = isset($request->is_active) ? 1 : 0;
        $temp_id = $request->input('template');        
        $getTemplate = TemplateTranslation::find($temp_id);

        $body = $getTemplate->body;
        $body = str_replace('<img src="', '<img src="'.env('APP_URL'), $body);
        
        $htmlContent = "<html>";
        $htmlContent .= "<body>";
        $htmlContent .= $body;
        $htmlContent .= "</body>";
        $htmlContent .= "<html>";
        $fromName = env('MAIL_FROM_NAME');

         // Define validation rules
        $rules = [
            'subscribers' => 'required|array|min:1', // Ensure at least one subscriber is selected
            'subject' => 'required',
            'template' => 'required',
                      
        ];

        // Create custom error messages
        $customMessages = [
            'required' => ':attribute field is required.',            
        ];

        $request->validate($rules, $customMessages);

         // ***  SEND MAIL  *** //
        // $to = env('MAIL_USERNAME');                
        $fromEmail = 'ashik@santhila.co'; // Set the common "Reply-To" address
        $subject = $email->subject; 
        $message = $htmlContent;
        $headers = "MIME-Version: 1.0" . "\r\n"; 
        $headers .= "Content-type:text/html;charset=UTF-8" . "\r\n"; 
        $headers .= 'From: ' . $fromName . "\r\n" . 
        'Reply-To: ' . $fromEmail . "\r\n" . 
        'X-Mailer: PHP/' . phpversion();
        foreach ($subscribers as $subscriber) {
            $to = $subscriber; // Set the recipient's email address for this iteration
            $success = mail($to, $subject, $message, $headers); 
            dd($success);          
            if (!$success) {
                $errorMessage = error_get_last()['message'];
            }
        }

        
        // Check if the record exists
        if ($email) {
            // Update the fields you want to modify
            $email->subscribers = json_encode($request->input('subscribers'));
            $email->subject = $request->input('subject');
            $email->template = $getTemplate->name;
            $email->date = $request->input('date');
            $email->is_active = $is_active;
            
            // Save the changes
            $email->save();

             // Flash a success message
            session()->flash('success', 'Email updated successfully');
    
            // Optionally, you can return a response or redirect            
            return redirect('admin/emails');
        } else {
            // Handle the case where the record with the given ID was not found
            return response()->json(['message' => 'Email not found'], 404);
        }
    }




   
    
}










// {{ Form::select('subscribers[]',trans('email::attributes.subscribers'),  $errors, $getSubscriber, ['labelCol' => 2, 'required' => true, 'multiple'=>true]) }}
// print_r(Form::select('subscribers[]',trans('email::attributes.subscribers'),  $errors, $getSubscriber, ['labelCol' => 2, 'required' => true, 'multiple'=>true]));
// {{ Form::text('subject', trans('email::attributes.subject'), $errors, $email, ['labelCol' => 2, 'required' => true]) }}
// {{ Form::select('template[]', trans('email::attributes.template'), $errors, $getTemplate, ['labelCol' => 2, 'required' => true]) }}
// {{ Form::text('date', trans('email::attributes.date'), $errors, $email, ['labelCol' => 2, 'required' => true]) }}
// {{-- {{ Form::select('brand_id', trans('product::attributes.brand_id'), $errors, $product, $product) }} --}}
// <div class="row">
//     <div class="col-md-8">
//         {{ Form::checkbox('is_active', trans('email::attributes.is_active'), trans('email::emails.form.enable_the_email'), $errors, $email) }}
//     </div>
// </div>    
// this is edit






// {{ Form::select('subscribers[]',trans('email::attributes.subscribers'),  $errors, $getSubscriber, ['labelCol' => 2, 'required' => true, 'multiple'=>true]) }}
// {{ Form::text('subject', trans('email::attributes.subject'), $errors, $email, ['labelCol' => 2, 'required' => true]) }}
// {{ Form::select('template[]', trans('email::attributes.template'), $errors, $getTemplate, ['labelCol' => 2, 'required' => true]) }}
// {{ Form::text('date', trans('email::attributes.date'), $errors, $email, ['labelCol' => 2, 'required' => true]) }}
// {{-- {{ Form::select('brand_id', trans('product::attributes.brand_id'), $errors, $product, $product) }} --}}
// <div class="row">
//     <div class="col-md-8">
//         {{ Form::checkbox('is_active', trans('email::attributes.is_active'), trans('email::emails.form.enable_the_email'), $errors, $email) }}
//     </div>
// </div>
// this is create