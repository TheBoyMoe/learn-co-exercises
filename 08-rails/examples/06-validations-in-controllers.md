## Validations in Controllers

Example

```ruby
	# app/controllers/posts_controller.rb
   
    def create
      # Create a brand new, unsaved, not-yet-validated Post object from the form.
      @post = Post.new(post_params)
   
      # Run the validations WITHOUT attempting to save to the database, returning
      # true if the Post is valid, and false if it's not.
      if @post.valid?
        # If--and only if--the post is valid, do what we usually do.
        @post.save
        # redirect_to returns a status_code of 302, which instructs the browser to
        # perform a NEW REQUEST - page reload (AKA: throw @post (so losing the 
 				# error message(s) in the errors collection) away and let the show action
        # worry about re-reading it from the database)
        redirect_to post_path(@post)
      else
        # If the post is invalid, hold on to @post, because it is now full of
        # useful error messages, and re-render the :new page, which knows how
        # to display them alongside the user's entries.
 				# 'render' can render the templates from other actions
 				# by simply specifying the template name, e.g. :new, :show, etc.
        render :new
      end
    end
```