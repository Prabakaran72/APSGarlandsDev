<?php

namespace Modules\Template\Http\Controllers\Admin;

use Modules\Template\Entities\TemplateTranslation;
use Modules\Template\Entities\Template;
use Modules\Admin\Traits\HasCrudActions;
use Modules\Template\Http\Requests\SaveTemplateRequest;
use Illuminate\Http\Request;
use Newsletter;

class TemplateController
{
    use HasCrudActions;

    /**
     * Model for the resource.
     *
     * @var string
     */
    protected $model = Template::class;

    /**
     * Label of the resource.
     *
     * @var string
     */
    protected $label = 'template::templates.template';

    /**
     * View path of the resource.
     *
     * @var string
     */
    protected $viewPath = 'template::admin.templates';

    /**
     * Form requests for the resource.
     *
     * @var array|string
     */
    protected $validation = SaveTemplateRequest::class;



    // public function store(Request $request) {
        
    //     $name = $request->name; 
    //     $html = $request->body;               
    //     // $html = '<html><body>Your template content goes here</body></html>';
    //     $getTemplate = Newsletter::addTemplate($name, $html);


    //     $template = new TemplateTranslation();

    //     $template->name = $request->input('name');
    //     $template->body = $request->input('body');
    //     $template->is_active = $request->input('is_active');        
    //     $template->save();

    //     if($template->id)
    //     {            
    //         session()->flash('success', 'Template created successfully');
    //         return redirect()->back();
    //     }
    //     dd($template->template_id);
                
    //     return redirect()->back();
    // }
}
