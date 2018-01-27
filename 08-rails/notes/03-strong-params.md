## Strong params


```ruby
	# basic implementation /review/08-strong-params-basics
	# app/controllers/posts_controller.rb 
   
  def create
    @post = Post.new(post_params)
    @post.save
    redirect_to post_path(@post)
  end
   
  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    redirect_to post_path(@post)
  end
   
  private
   
  def post_params
    params.require(:post).permit(:title, :description)
  end
```

```ruby
	# pass different attributes in different controller actions
  # app/controllers/posts_controller.rb
   
  def create
    @post = Post.new(post_params(:title, :description))
    @post.save
    redirect_to post_path(@post)
  end
   
  def update
    @post = Post.find(params[:id])
    @post.update(post_params(:title))
    redirect_to post_path(@post)
  end
   
  private
   
  # We pass the permitted fields in as *args;
  # this keeps `post_params` pretty dry while
  # still allowing slightly different behavior
  # depending on the controller action
  def post_params(*args)
    params.require(:post).permit(*args)
  end
```
