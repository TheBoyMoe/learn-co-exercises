# Returning String Data

## Objectives

  * Return plain strings as HTTP responses
  * Explain how the Internet is really just sending strings!
  * Replace a DIV with a string fetched over HTTP

## Lesson

As developers, we do our best to hide it, but all of the Internet is
just a bunch of strings being passed around from place to place. Don't
tell the cats.

![cat string](http://i.giphy.com/DXgkevJQFPhew.gif)

We put formats around our strings so that we can render them in an
agreed-upon way, but it's all just strings. All you have to do is drop
into your terminal and try: `curl https://twitter.com`.

When the browser requests this URL, this is what it sees. Just one big
string of markup (HTML) and data. Then it interprets the markup and
turns it into Twitter. But on the console, with nothing to turn the HTML
into something, we just see the string.

So if the Internet is just strings, do we always need the markup?

### Returning Raw Strings from Controller Actions

Included in this repo is a blog application. Run `rake db:seed` and then
launch the Rails server and browse to `/posts`.

Okay, we have a pretty basic post title and content here, with a teaser
to only show the first bit of the post body. We want to give them a way
to interact and ask for the whole post body, so we'll add a button to
fill in the rest.

We want to do this without redirecting to the post `show` path, so we're
going to use an AJAX request to replace the truncated content with the
full body.

The first thing we'll need is a route and controller action to get the
body of the post.

```ruby
# routes.rb
# ...
get '/posts/:id/body', to: 'posts#body'
```

And in our controller:

```ruby
# posts_controller.rb
# ...
  def body
    post = Post.find(params[:id])
    render plain: post.description
  end
```

Note the `render plain:` call in the controller. Normally, in a RESTful
action, we allow the controller to implicitly render a template with the
same name as the action. Here, however, we want to *explicitly* render
plain text, so we call `render` with the `:plain` option.

**Note:** There are a lot of options for `render`, including plain text,
files, or nothing at all. Read more about `render` in the [Layouts and
Rendering](http://guides.rubyonrails.org/layouts_and_rendering.html#using-render) RailsGuide.

Now that we have that action, we can hit it by browsing to
`/posts/:id/body` and see that we are just rendering plain text. 

**Hint:** The `/posts` page outputs the post `id` as part of the `<h1>`
tag, so you can easily get an `id` to use to test this out.

This route isn't useful at all to the HTML portion of the site, because it has no markup, so we have to consume it another way. That means we just wrote our first API endpoint!

### Consuming a Simple API Endpoint with AJAX

Okay, we have an API endpoint where we can get the rest of a post body.
Now it's just a matter of providing a way for the user to request it,
and getting the string response onto the page.

Let's start by adding a button. In our `_post.html.erb` partial, we want
to provide a button for each post to request the body.

It has to be tied to each post so that we can know which post's body
we're requesting, which means we'll need to make use of the `post.id` to
pass along to our route.

```erb
# _post.html.erb
<h1><%= post.id %>: <%= post.title %></h2>
<div><%= truncate post.description %></div>

<button class="js-more" data-id="<%= post.id %>">More...</button>
```

**Note:** We're using the [`truncate` helper](http://api.rubyonrails.org/classes/ActionView/Helpers/TextHelper.html#method-i-truncate) here to only show a portion of the potentially long `description` string. By default, `truncate` will cut off everything after 30 characters.

We need a way to attach a `click()` event listener to the button in
JavaScript. Since there will be multiple buttons on the page that need
to respond to the click, we're using `class="js-more"` as an identifier,
rather than an `id` attribute. Prefixing the `class` name with `js-` is
a common way to communicate that this class is used as a JavaScript
selector.

We also need to tie the button to a `post`, since it has to ask for the
right content, so we're using a [data-* attribute](https://developer.mozilla.org/en-US/docs/Web/Guide/HTML/Using_data_attributes) of `data-id` to hold the `post.id` for us.

Now that we have that, let's wire up a `click()` listener to our
`js-more` buttons and request the post body.

We'll use `jQuery` to wire it up in [document `.ready()`](https://api.jquery.com/ready/) in our `index.html.erb` template. Why not the `_post` partial? We only want to do this code once, and the partial will be loaded as many times as we have posts, so putting it in the main template ensures we just use it one time.

```erb
# posts/index.html.erb
<% @posts.each do |post| %>
  <%= render partial: "post", locals: {post: post} %>
<% end %>

<script type="text/javascript" charset="utf-8">
$(function () {
  $(".js-more").on('click', function() {
    // get the id from the data attribute
    var id = $(this).data("id");
    $.get("/posts/" + id + "/body", function(data) {
      alert(data);
    });
  });
});
</script>
```

We've set up a `click` listener for all our `.js-more` buttons, and used
the `.get()` method to make an AJAX request to our `/posts/:id/body`
route using the `id` we stored in the `data-id` attribute on the button.

So, if we reload the page and click "more" on a post, we should get an
alert with the body of that post.

### Replacing Text with the API Response

The last thing we need to do is swap out that `alert(data)` call with
actually putting the response into the body of our post.

If we look back at `_post.html.erb`, we see that our body is in a
`<div>`. All we need to do is replace the inner text of that `<div>`. To
do that, we need to identify it with the `post.id`.

```erb
# _post.html.erb
<h1><%= post.id %>: <%= post.title %></h2>
<div id="body-<%= post.id %>"><%= truncate post.description %></div>

<button class="js-more" data-id="<%= post.id %>">More...</button>
```

Now we've identified the element as `body-id`, so each `div` will have a
predictable `id`, like `body-1`, `body-2`, and so on.

With that in place, we just need to update our JavaScript to find the
right `div` by `id` and replace the text:

```erb
# posts/index.html.erb
# ...
<script type="text/javascript" charset="utf-8">
$(function () {
  $(".js-more").on('click', function() {
    var id = $(this).data("id");
    $.get("/posts/" + id + "/body", function(data) {
      // Replace text of body-id div
      $("#body-" + id).text(data);
    });
  });
});
</script>
```

We simply use the `#` selector to find the right `body-id`, and call
`.text(data)` to replace the text of the `div` with what we got back
from our API call.

If we reload the page now, and click "More..." on our posts, we should
see the truncated text replaced with the full text!

Congratulations, you've just implemented and consumed your first
internal API endpoint!

## Summary

We've reminded ourselves that the Internet is run by passing strings
around, and that we can use Rails to return plain-text strings without
markup from our API endpoints.

We've also seen how we can easily request non-HTML data from the client
to the server and use the response on the page without needing to render
an entire page or redirect.

**Cliffhanger:**

![mission impossible](http://i.giphy.com/w39FdnnX0scIE.gif)

What if we wanted all of the data from a post, and not just the body,
from that API endpoint? What if we wanted to display the `show` page
without doing a page refresh? Certainly we wouldn't want to make a bunch
of separate requests to endpoints like `/post/:id/body` and
`/post/:id/title` and `/post/:id/author`, would we? There has to be a
better way!

