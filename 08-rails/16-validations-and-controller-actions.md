# Validations in Controller Actions

Now that we know Rails automatically performs validations defined on models, let's use this information to help users fix typos or other problems in their form submissions.

At this point, we'll be covering step two of the following flow:

1. User fills out the form and hits "Submit", transmitting the form data via a POST request.
2. **The controller sees that validations have failed, and re-renders the form.**
3. The view displays the errors to the user.


# Objectives

After this lesson, you'll be able to...

- Define validations on a model
- Use the validation state of a model in a response conditional in an action
- Re-render a form with validation errors
- Validate a create action
- Validate an update action

# Manually Checking Validation

Up until this point, our `create` action has looked something like this:

```ruby
# app/controllers/posts_controller.rb

  def create
    @post = Post.create(post_params)

    redirect_to post_path(@post)
  end
```

However, we have two problems now:

1. If the post is invalid, there will be no `show` path to redirect to. The post was never saved to the database, so that `post_path` will result in a 404!
2. If we redirect, we start a new page load, which will lose all of the feedback from the validations.

## A Note About Page Loads

When a form is submitted, a **full page load** occurs, as if you had navigated to a completely new URL. This means that all of the variables set by the controller's `new` action (like `@post`) *disappear* and are unavailable to the `create` action.

The browser throws everything out after each request, except for cookies.

Rails throws everything out after each request, except for the `session` hash.

You're probably used to validations happening almost instantaneously on websites that you interact with on a daily basis. When you get validation feedback *without* a full page load, that's JavaScript at work, sneakily performing requests in the background without throwing away the current page. We won't be using that advanced technique just yet!

Let's use `valid?` to see what's going on before deciding how to respond:

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
      # This returns a status_code of 302, which instructs the browser to
      # perform a NEW REQUEST! (AKA: throw @post away and let the show action
      # worry about re-reading it from the database)
      redirect_to post_path(@post)
    else
      # If the post is invalid, hold on to @post, because it is now full of
      # useful error messages, and re-render the :new page, which knows how
      # to display them alongside the user's entries.
      render :new
    end
  end
```

`render` can be instructed to render the templates from other actions. In the above code, since we want the `:new` template from the same controller, we don't have to specify anything except the template name.

You can read more about this (and other) creative uses of `render` in Section 2.2.2 of the Rails Guide on [Layout and Rendering][layout_rendering].

[layout_rendering]: http://guides.rubyonrails.org/layouts_and_rendering.html#using-render

Remember: **redirects incur a new page load**. When we redirect after validation failure, we **lose** the instance of `@post` that has feedback (messages for the user) in its `errors` attribute.

Another way to differentiate redirects is this:

- If you hit Refresh after a redirect/page load, your browser resubmits the `GET` request without complaint.

- If you hit Refresh after rendering on a form submit, your browser gives you a popup to confirm that you want to resubmit form data with the `POST` request.

In the next lessons, we'll learn how to use the error information in `@post.errors` to display feedback to the user through our view.
