# Validations with `form_for`


## Differences between `form_for` and `form_tag`

- `form_for` creates a form specifically **for** a model object.
- `form_for` automatically performs a route lookup to find the right URL for post.

`form_for` takes a block. It passes an instance of [FormBuilder](http://api.rubyonrails.org/classes/ActionView/Helpers/FormBuilder.html) as a parameter to the block.

A basic implementation looks like this:

```erb
<!-- app/views/posts/edit.html.erb //-->

<%= form_for @post do |f| %>
  <%= f.text_field :title %>
  <%= f.text_area :content %>
  <%= f.submit %>
<% end %>
```

This creates the HTML:

```html
<form class="edit_post" id="edit_post" action="/posts/1" accept-charset="UTF-8" method="post">
  <input name="utf8" type="hidden" value="&#x2713;" />
  <input type="hidden" name="_method" value="patch" />
  <input type="hidden" name="authenticity_token" value="nRPP2OqVKB00/Cr+8EvHfYrb5sAkZRtr8f6dzBaJAI+cMceR0fUatcLWd4zdwYCpojW2J3QLK6uyBKeFAgZvmw==" />
  <input type="text" name="post[title]" id="post_title" value="Existing Post Title"/>
  <textarea name="post[content]" id="post_content">Existing Post Content</textarea>
  <input type="submit" name="commit" value="Update Post" />
</form>
```

Here's what we would need to do with `form_tag` to generate the exact same HTML:

```erb
<!-- app/views/posts/new.html.erb //-->

<%= form_tag post_path(@post), method: "patch", name: "edit_post", id: "edit_post" do %>
  <%= text_field_tag "post[title]", @post.title %>
  <%= text_area "post[content]", @post.content %>
  <%= submit_tag "Update Post" %>
<% end %>
```

- `form_tag` doesn't know what action we're going to use it for, because it has no model object to check. 
- `form_for` knows that an empty, unsaved model object needs a `new` form and a populated object needs an `edit` form. This means we get to skip all of these steps:

1. Setting the `name` and `id` of the `<form>` element.
2. Setting the method to `patch` on edits.
3. Setting the text of the `<submit>` element.
4. Specifying the root parameter name (`post[whatever]`) for every field.
5. Choosing the attribute (`@post.whatever`) to fill for every field.


## Using `form_for` to generate empty forms

To wire up an empty form in our `new` view, we need to create a blank object:

```ruby
# app/controllers/posts_controller.rb

  def new
    @post = Post.new
  end
```

Here's our usual vanilla `create` action:

```ruby
# app/controllers/posts_controller.rb

  def create
    @post = Post.create(post_params)

    redirect_to post_path(@post)
  end
```

We still have to solve the dual problem of what to do when there's no valid model object to redirect to, and how to hold on to our error messages while re-rendering the same form.

## Re-Rendering With Errors

Remember from a few lessons ago how CRUD methods return `false` when validation fails? We can use that to our advantage here and branch our actions based on the result:

```ruby
# app/controllers/posts_controller.rb

  def create
    @post = Post.new(post_params)

    if @post.save
      redirect post_path(@post)
    else
      render :new
    end
  end
```

## Full Messages with Prepopulated Fields

Because of `form_for`, Rails will automatically prepopulate the `new` form with the values the user entered on the previous page.


```erb
<!-- app/views/posts/new.html.erb //-->

<% if @post.errors.any? %>
  <div id="error_explanation">
    <h2>
      <%= pluralize(@post.errors.count, "error") %>
      prohibited this post from being saved:
    </h2>

    <ul>
    <% @post.errors.full_messages.each do |msg| %>
      <li><%= msg %></li>
    <% end %>
    </ul>
  </div>
<% end %>
```

## More Freebies: `field_with_errors`

Let's look at another nice feature of `FormBuilder`. Here's our `form_for` code again:

```erb
<!-- app/views/posts/edit.html.erb //-->

<%= form_for @post do |f| %>
  <%= f.text_field :title %>
  <%= f.text_area :content %>
  <%= f.submit %>
<% end %>
```

The `text_field` call generates this tag:

```html
<input type="text" name="post[title]" id="post_title" value="Existing Post Title"/>
```

Not only will `FormBuilder` pre-fill an existing `Post` object's data, it will also wrap the tag in a `div` with an error class if the field has failed validation(s):

```html
<div class="field_with_errors">
  <input type="text" name="post[title]" id="post_title" value="Existing Post Title"/>
</div>
```

This can also result in some unexpected styling changes because `<div>` is a block tag (which takes up the entire width of its container) while `<input>` is an inline tag. 
