# Receiving API POSTs

## Objectives

  1. Serialize form values into `params` for AJAX POST requests.
  2. Use those `params` to create resources.
  3. Return and consume the created resource as JSON.

## Lesson

So far, we've been focused on enhancing how we read our blog, but what
about creating blog posts? How can we apply what we've been doing with
JSON and AJAX to make creating a post a better experience?

### Creating a Post With an AJAX POST

In our `posts/new.html.erb`, we already have a form. If we click the
button, it will submit as normal and the code in the controller's
`create` action will do whatever it's set up to do.

What we want to do is set it up so that we use this form, but use jQuery
and AJAX to submit it, so that we can handle a JSON response and display
the newly created blog post without redirecting to the post `show` page.

Our first order of business is to prevent the default form submit action and
do our own thing. To do this, we need to hook up an event handler to the
form's `submit` event, and then block the form from doing an HTML
submit as it normally would.

```erb
# posts/new.html.erb
<%= form_for(@post) do |f| %>
  <div class="field">
    <%= f.label :title %><br>
    <%= f.text_field :title %>
  </div>
  <div class="field">
    <%= f.label :description %><br>
    <%= f.text_field :description %>
  </div>
  <div class="actions">
    <%= f.submit %>
  </div>
<% end %>

<script type="text/javascript" charset="utf-8">
  $(function () {
    $('form').submit(function(event) {
      //prevent form from submitting the default way
      event.preventDefault();
      alert("we r hack3rz");
    });
  });
</script>
```

We keep our regular `form_for` and just add an event listener for
`$('form').submit()` to our document `ready()`.

Next, we stop the form from actually submitting by calling
`event.preventDefault();`. This is super important, otherwise all our
hard work will be undone.

Finally, we'll just toss up an `alert` to make sure we're on the right
path.

If we reload `/posts/new` now, and submit the form, we should get our
`alert`, but no page refresh and no new post created. We've successfully
hijacked the form `submit`! This is as close as we may ever come to
being l33t.


Okay, that was fun, but let's do the real work. We need to get the form
values and POST them to `/posts`, which is the route for creating a new
post.

```erb
# posts/new.html.erb
# ...
<script type="text/javascript" charset="utf-8">
  $(function () {
    $('form').submit(function(event) {
      //prevent form from submitting the default way
      event.preventDefault();

      var values = $(this).serialize();

      var posting = $.post('/posts', values);

      posting.done(function(data) {
        // TODO: handle response
      });
    });
  });
</script>
```

In here, we're making use of the very handy [jQuery `serialize()`
method](http://api.jquery.com/serialize/), which takes our form data and
serializes it for us. Sure, we could individually select each
form element and build our own JSON data, but we've done enough
of that in this unit, so we've earned this shortcut!

Next we use jQuery `post()`, much like we've been using `get()` to
retrieve data. We pass it the URL and our `values`.

Finally, we're using the `posting` object to specify what should happen
when the AJAX request is `done`. This is where we'll need to handle the
response.

**Advanced:** The jQuery `post()` method returns a [jqXHR](http://api.jquery.com/jQuery.ajax/#jqXHR) object, which we're storing in our `posting` variable. These `jqXHR` objects implement the [Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise) interface, which is used for deferred or asynchronous operations.

If we reload our form and try to create a blog post... nothing happens.

OR DOES IT?


If we look at our running Rails server, we'll probably see something
like this:

```erb
Started POST "/posts" for ::1 at 2016-02-23 01:48:39 -0500
Processing by PostsController#create as */*
  Parameters: {"utf8"=>"✓", "authenticity_token"=>"k2thnauWV/3diGaOesdnSZaygMsA7tR7N0qa/HVk4M2IO4Q0HCuOnTF43NgaAZr/2N/5iHyKu6boAB/fVb0sww==", "post"=>{"title"=>"123abc", "description"=>"easy as"}}
```

That looks just like a regular POST with regular `params`. Since Rails
does the work of creating a `params` hash for us, it doesn't matter if
it comes from the form or from an AJAX request.

Okay, so we did create a post. But if we look in our controller, we're
supposedly redirecting to our `post_path`. And if we look further into
our running Rails server, we'll see that it *did* redirect after
creating our post. What gives?

### Getting a Response from an AJAX POST

When we do an AJAX request, we're expecting data to be returned so that
we can deal with it on the client side. So when our controller
redirected and rendered the post `show` page, it actually sent that data
to the `.done()` method.

You can see this in action by adding a `console.log(data)` inside the
`.done()` function and then inspecting the response.

```javascript
//...
  posting.done(function(data) {
    // TODO: handle response
    console.log(data);
  });
//...
```

You'll see the full HTML of the `show` page for that new post.

#### A Side-note About HTTP Codes

HTTP status codes exist to let the client know what kind of response
they are getting, and what to do with it.

The code for the kind of redirect that happens when we put `redirect_to` in our controller is `302`. When a browser makes a request, and gets a `302` code, it knows that it needs to follow the "redirect" to the
given link and load that page next.

**Advanced:** The `302` redirect is considered a *temporary*, or *found* redirect, as in, "You found the
right thing, but now go to this URL." There's other `300` codes as well, and they all deal with redirects, such as the `301` redirect, which tells the requestor that the resource they are looking for has moved permanently. Check out the full list of HTTP codes [here](https://en.wikipedia.org/wiki/List_of_HTTP_status_codes#3xx_Redirection).

AJAX requests don't follow redirects because they *can't*. If they did,
then you would lose any code that happens in the `done()` function and
just go to a new page that doesn't have that JavaScript code.

So when an AJAX request sees a 302, it chooses not to follow the link
and instead just takes whatever the rendered data is.

Rails handles HTTP codes for us when we do HTML requests, but when we
build JSON APIs, we need to be cognizant of using the appropriate codes
to let the client know what to expect.

We'll see this in action shortly.

### Rendering the Response

What we really want to do is get a JSON representation of the post we
just created so that we can use it to display the new post without
redirecting or refreshing the page.

Let's get into the controller, get rid of that redirect, and use the
ActiveModel::Serializer that we already have.

```ruby
# posts_controller.rb
# ...
  def create
    @post = Post.create(post_params)
    render json: @post, status: 201
  end
```

**Note:** We are specifying the `status: 201` for this request, rather
than the standard `200`, which means `OK`. Technically, this is a
successful request and could be considered `200`, but we want to
specify what happened more granularly, and `201` means that the resource
was `created`.

With our controller code in place, we need to make some additions to our
template to handle the response and display it on the page.

```erb
<%= form_for(@post) do |f| %>
  <div class="field">
    <%= f.label :title %><br>
    <%= f.text_field :title %>
  </div>
  <div class="field">
    <%= f.label :description %><br>
    <%= f.text_field :description %>
  </div>
  <div class="actions">
    <%= f.submit %>
  </div>
<% end %>

<div id="postResult">
  <h2 id="postTitle"></h2>
  <p id="postBody"></p>
</div>

<script type="text/javascript" charset="utf-8">
  $(function () {
    $('form').submit(function(event) {
      //prevent form from submitting the default way
      event.preventDefault();

      var values = $(this).serialize();

      var posting = $.post('/posts', values);

      posting.done(function(data) {
        var post = data;
        $("#postTitle").text(post["title"]);
        $("#postBody").text(post["description"]);
      });
    });
  });
</script>
```

Very similar to what we've been doing when we use AJAX to `get()` a
resource, we just parse the JSON and add it to the DOM. To keep it
simple, we just have one `<DIV>` that has placeholders for the data, and
we fill it in when we get that response.

## Summary

We've learned how to POST a form using jQuery, render a response, and
handle that response on the page so that we can create a new resource
and show it to the user without ever leaving the page!

