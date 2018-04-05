# Pagination with Kaminari

## Objectives

1. Use the Kaminari gem to paginate blog posts.

## Lesson

We're going to be using the Kaminari gem to paginate our blog posts so that each page is more manageable.

Start by running `rake db:seed` on the included app. This is going to
create a bunch of posts. Next run your server and browse to `/posts`.

What a nightmare, right? So many posts on one page! What we need is an
easy way to only show a certain amount of posts per page, and allow the
user to go through them page by page.

### Kaminari To The Rescue

Kaminari is a Japanese word meaning "thunder", and the obvious link
between that and this lesson is that the [Kaminari](https://github.com/amatsuda/kaminari) gem makes pagination a
slam dunk.

![thunder dunk](http://i.giphy.com/K7so6CUdxkW1a.gif)

Let's just roll with that. You know. Like thunder.

To get started, we'll add Kaminari to our Gemfile:

`gem 'kaminari'`

Then run `bundle install` to get it installed.

Now let's run `rails g kaminari:config` to generate a configuration file
for Kaminari. You can find the file in `config/initializers`. Let's look
inside:

```ruby
# config\initializers\kaminari_config.rb

Kaminari.configure do |config|
  # config.default_per_page = 25
  # config.max_per_page = nil
  # config.window = 4
  # config.outer_window = 0
  # config.left = 0
  # config.right = 0
  # config.page_method_name = :page
  # config.param_name = :page
end
```

These are the defaults. The one we're interested in is
`default_per_page`, which sets up how many results will be in each page.
Let's change that to 10 (don't forget to un-comment it).


```ruby
# config\initializers\kaminari_config.rb

Kaminari.configure do |config|
  config.default_per_page = 10
# ...
```
Restart your Rails server to make sure the new gem and initializer are
picked up.

Okay. Now let's get into the controller and set our query up to use
Kaminari.

```ruby
# controllers\posts_controller.rb

# ...
  def index
    @posts = Post.order(created_at: :desc).page(params[:page])
  end
# ...
```

Here we're getting posts by most recent and then using the `page` method
of Kaminari to get a "page" (ten, in our case) of results. We're passing
`params[:page]` to the `page` method so that we can control *which* page
we get. And if `params[:page]` is `nil`, we'll get the first page, so it
works by default.

If you reload your `/posts` page, you should see that we're now limited
to ten results, which is much more manageable!

But how do we get to the next page of results?

Kaminari provides us with plenty of helpers to output navigation
controls. Let's start by adding regular pagination controls with the
`paginate` helper:

```erb
# views\posts\index.html.erb

<h1>Blog Posts!</h1>
<%= paginate @posts %>

<% @posts.each do |post| %>
# ...
```

Reload the page and we now have the ability to go next, previous, first,
last, or by page number.

If we want to add a little more contextual information, we can use the
`page_entries_info` helper, like this:

```erb
<h1>Blog Posts!</h1>
<%= page_entries_info @posts %>
<%= paginate @posts %>
<% @posts.each do |post| %>
# ...
```

And we can further customize our display, like, displaying only two page
numbers on either side of the current page by passing in a value for
`window`:

```erb
<h1>Blog Posts!</h1>
<%= page_entries_info @posts %>
<%= paginate @posts, window: 2 %>
<% @posts.each do |post| %>
# ...
```

More customization options for `paginate` can be found in the Kaminari [README](https://github.com/amatsuda/kaminari).

## Summary

We've seen just how easy it is to use Kaminari to quickly add
pagination to large datasets in our app, despite still having no idea
why it's named after thunder.
