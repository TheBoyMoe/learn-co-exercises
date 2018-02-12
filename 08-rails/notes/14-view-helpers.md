## View Helpers

1. are organised by controller, e.g. `PostsController` -> `app/helpers/posts_helper.rb`
2. helpers are accessible from every view, no matter which file they are saved to.
3. use `application_helper.rb` for helpers that need to be accessible from a number or all views
4. you can call rails's built in helpers from your own cusomt helpers.


```ruby
# app/helpers/application_helper.rb
 
def title(text)
  content_for :title, text
end
```

```html
<!-- app/views/layouts/application.html.erb -->
<head>
  <title><%= yield :title %></title>
</head>
```

We can now use the title helper to change the page title of any page

```html
<!-- app/views/authors/show.html.erb -->

<% title @author.name %>
 
<h1><%= @author.name %></h1>
<p>Posts:</p>
<% @author.posts.each do |post| %>
  <div><%= post.title %> - <%= last_updated post %></div>
<% end %>
```

```html
<!-- app/views/posts/show.html.erb -->
 
<% title @post.title %>
 
<h1><%= @post.title %></h1>
<p><%= last_updated @post %></p>
<p><%= @post.description %></p>
```