<?php

namespace Modules\Account\Http\Controllers;

use Modules\Blogpost\Entities\Blogpost;
use Modules\Blogtag\Entities\Blogtag;
use Illuminate\Http\Request;
use Modules\Blogcategory\Entities\Blogcategory;
use Modules\Blogpost\Http\Requests\SaveBlogpostRequest;
use Modules\Media\Entities\File;
use Modules\Blogpost\Entities\Blogpostlikesdislikes;
use Modules\Blogpost\Entities\Blogpostcomments;
class AccountBlogformController
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $blogpost = auth()->user()
            ->blogposts()->with('category')
            ->paginate(20);

        return view('public.account.blogform.index', compact('blogpost'));
    }
    public function create()
    {        $Blogcategory = Blogcategory::all();
              $Blogtag=Blogtag::all();

        return view('public.account.blogform.create',compact('Blogcategory','Blogtag'));
    }
    public function edit($id)
    {
              $Blogcategory = Blogcategory::all();
              $Blogtag=Blogtag::all();
              $Blogpost=Blogpost::find($id);
        return view('public.account.blogform.edit',compact('Blogcategory','Blogtag','Blogpost'));


    }
    public function store(Request $request)
    {

   $input=$request->all();
   $tags=$input['tag_id'];
   $input['tag_id']=implode(',',$tags);
   BlogPost::create($input);

        return redirect()->route('account.blogform.index')->with('success', 'Blog Post added successfully!');
       
    }
 public function update(SaveBlogpostRequest $request, $id)
    {
        $blogpost = Blogpost::find($id);
        $tags=$request->tag_id;
        $tag_id_value=implode(',',$tags);
        $update_postform = [
            'category_id' => $request->category_id,
            'tag_id' => $tag_id_value,
            'post_title' => $request->post_title,
            'post_body' => $request->post_body,
            'author_id' => $request->author_id,
        ];
        $blogpost->update($update_postform);
        return redirect()->route('account.blogform.index')->with('success', 'Blog Post Updated successfully!');

    }
    
    public function destroy($id)
    {
        BlogPost::find($id)->delete();

        return redirect()->route('account.blogform.index')->with('success', 'Blog Post deleted successfully!');

    }
    ////blogs list form///
    public function testindex()
    {        $Blogcategory = Blogcategory::all();
              $Blogtag=Blogtag::all();
              $Blogpost=Blogpost::with('users')->paginate(10);
        if (auth()->id()) {
        return view('public.account.blogs.index',compact('Blogcategory','Blogtag','Blogpost'));
        }else{
            return redirect()->route('login')->with('error', 'You are not authorized. Please Login and Try..!');
        }

    }
    public function showMore($id)
    {
        $blogpost = Blogpost::find($id);
        return view('public.account.blogs.show',compact('blogpost'));
    }
    public function commentsstore(Request $request)
    {
        $blogcomments=new Blogpostcomments;
        $blogcomments->post_id=$request->post_id;
        $blogcomments->comments=$request->comments;
        $blogcomments->author_id=auth()->id();
        $blogcomments->save();
        return redirect()->route('account.blogs.index')->with('success', 'Blog Comments added successfully!');
        
    }
    public function fetchCount(Request $request)
{
    $blogId = $request->blog;

    $likes = Blogpostlikesdislikes::where('post_id', $blogId)->sum('likes');
    $dislikes = Blogpostlikesdislikes::where('post_id', $blogId)->sum('dislikes');

    return [
        'likeCount' => $likes,
        'dislikeCount' => $dislikes,
    ]; 
}

    public function handleLike(Request $request)
    {   $user_id =auth()->id();
        $existingLike = Blogpostlikesdislikes::where('post_id', $request->blog)
        ->where('author_id', $user_id)
        ->first();
        if($existingLike){
        if($existingLike->likes=='1' && $existingLike->dislikes=='0')
        {
            $existingLike->delete();
            $counts = $this->fetchCount($request);
            $likeCount = $counts['likeCount'];
            $dislikeCount = $counts['dislikeCount'];

            return response()->json([
                'message' => 'DisLiked',
                'dislikeCount' => $dislikeCount,
                'likeCount' => $likeCount,
            ]);
            
        }else if($existingLike->likes=='0' && $existingLike->dislikes=='1')
        {
           $existingLike->dislikes='0';
           $existingLike->likes='1';
           $existingLike->save();
           $counts = $this->fetchCount($request);
           $likeCount = $counts['likeCount'];
           $dislikeCount = $counts['dislikeCount'];      
                 return response()->json([
                'message' => 'Liked',
                'likeCount' => $likeCount,
                'dislikeCount' => $dislikeCount,

            ]);
        }}else{$blog=new Blogpostlikesdislikes;
            $blog->post_id=$request->blog;
            $blog->likes=1;
            $blog->dislikes=0;
            $blog->author_id=auth()->id();
            $blog->save();
            $counts = $this->fetchCount($request);
            $likeCount = $counts['likeCount'];
            $dislikeCount = $counts['dislikeCount'];       
                 return response()->json([
                'message' => 'Liked',
                'likeCount' => $likeCount,
                'dislikeCount' => $dislikeCount,

            ]);
    }
    }
    public function handleDislike(Request $request)
    { try {
        $user_id =auth()->id();
        $existingdisLike = Blogpostlikesdislikes::where('post_id', $request->blog)
        ->where('author_id', $user_id)
        ->first();
        if($existingdisLike){
        if($existingdisLike->likes=='0' && $existingdisLike->dislikes=='1')
        {
            $existingdisLike->delete();
            $counts = $this->fetchCount($request);
            $likeCount = $counts['likeCount'];
            $dislikeCount = $counts['dislikeCount'];
            return response()->json([
                'message' => 'Un DisLiked',
                'dislikeCount' => $dislikeCount,
                'likeCount' => $likeCount,
            ]);
        } else if($existingdisLike->likes=='1' && $existingdisLike->dislikes=='0')
        {
            $existingdisLike->dislikes='1';
            $existingdisLike->likes='0';
            $existingdisLike->save();
            $counts = $this->fetchCount($request);
            $likeCount = $counts['likeCount'];
            $dislikeCount = $counts['dislikeCount'];
            return response()->json([
                'message' => 'DisLiked',
                'dislikeCount' => $dislikeCount,
                'likeCount' => $likeCount,
            ]);
        }
    }
        else
        {
        $blog=new Blogpostlikesdislikes;
        $blog->post_id=$request->blog;
        $blog->likes=0;
        $blog->author_id=auth()->id();
        $blog->dislikes=1;
        $blog->save();
        $counts = $this->fetchCount($request);
        $likeCount = $counts['likeCount'];
        $dislikeCount = $counts['dislikeCount'];
        return response()->json([
            'message' => 'DisLiked',
            'dislikeCount' => $dislikeCount,
            'likeCount' => $likeCount,

        ]);
    } } catch (\Exception $e) {
        
        return response()->json([
            'error' => 'An error occurred: ' . $e->getMessage(),
        ], 500); 
    }
    }
}
