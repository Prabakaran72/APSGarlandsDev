<?php

namespace Modules\Blogpost\Http\Controllers;

use Modules\Blogpost\Entities\Blogpost;
use Modules\Blogtag\Entities\Blogtag;
use Illuminate\Http\Request;
use Modules\Blogcategory\Entities\Blogcategory;
use Modules\Media\Entities\File;
use Modules\Blogpost\Entities\Blogpostlikesdislikes;
use Modules\Blogpost\Entities\Blogpostcomments;

class BlogpostController
{
    /**
     * Display page for the slug.
     *
     * @param string $slug
     * @return \Illuminate\Http\Response
     */
    
    
    // public function showMore($id)
    // {
    //     $blogpost = Blogpost::find($id);
    //     return view('public.blogs.show',compact('blogpost'));
    // }
    public function show($slug)
    {
        $logo = File::findOrNew(setting('storefront_header_logo'))->path;
        $blogpost = Blogpost::where('slug', $slug)->firstOrFail();

        return view('public.blogposts.show', compact('blogpost', 'logo'));
    }
    // public function testindex()
    // {        $Blogcategory = Blogcategory::all();
    //           $Blogtag=Blogtag::all();
    //           $Blogpost=Blogpost::with('users')->get();
    //     if (auth()->id()) {
    //     return view('public.blogs.index',compact('Blogcategory','Blogtag','Blogpost'));
    //     }else{
    //         return redirect()->route('login')->with('error', 'You are not authorized. Please Login and Try..!');
    //     }

    // }
    public function store(Request $request)
    {

   $input=$request->all();
   $tags=$input['tag_id'];
   $input['tag_id']=implode(',',$tags);
   BlogPost::create($input);

        return redirect()->route('account.blogform.index')->with('success', 'Blog Post added successfully!');
        //return redirect()->route('account.testimonials.index');
        // return redirect()->route('products.index');
    }
    // public function commentsstore(Request $request)
    // {

    //     $blogcomments=new Blogpostcomments;
    //     $blogcomments->post_id=$request->post_id;
    //     $blogcomments->comments=$request->comments;
    //     $blogcomments->author_id=auth()->id();
    //     $blogcomments->save();
    //     return redirect()->route('blogs.index')->with('success', 'Blog Comments added successfully!');
    //     //return redirect()->route('account.testimonials.index');
    //     // return redirect()->route('products.index');
    // }
}
