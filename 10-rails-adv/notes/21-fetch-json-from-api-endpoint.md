# DIY JSON Serializer

## Objectives

  1. Explain what JSON is.
  2. Create and return simple JSON Objects by hand.
  3. Load those objects with AJAX into HTML.

## Overview

Continuing with our blog application, we'll be improving our blog post
API to provide more structure and more efficient data access. Make sure
to run `rake db:seed` to set up some starting data!

Last time, we created an endpoint for the single piece of data we wanted
to access. That worked well enough, but doesn't scale. If we want to use
AJAX to get all the data from a blog post, we'd be creating so many
endpoints, and making so many GET requests.

What we really need is one endpoint to make one request and get back
structured data representing our blog post.

### Serialization

If we're directly accessing a post from our web browser, the answer is
simple. The controller renders a template that contains HTML and the
data we need.

We could still do this for an API endpoint, but then that HTML would
probably get in our way. We want the data, not the formatting. This,
like so many things, comes back to Separation of Concerns. An API
endpoint is only concerned with returning the data needed; it's up to
the API consumer, in this case our AJAX call, to decide how to display
it.

This is where **serialization** comes in. Serialization is the process
by which we take "executable" code, in our case a Ruby object, and
represent it as a string that can be consumed anywhere (remember, the
Internet is just strings) and then reconstructed back into usable code.

Remember that a Ruby *object* is an instance of a *class*,
meaning it has been initialized and is running in memory. Serializing an
object retains the *state*, or current values of all the object's
attributes, when turning it into a string. This differs from a class
definition because the class definition tells us what *any* object *could*
look like, whereas a serialized object tells us what *one* object *does*
look like. It's an important distinction.

Most of what a modern web API does is gather and serialize objects to be
passed to the consuming code as a string over HTTP. So how do we do this
serialization?

At one time, the standard was XML. XML is a structured, tag-based markup
language similar to HTML. The tags are specified by the API provider and
ideally describe the object being serialized in an organized,
human-readable way.

An example of serializing a post into XML might be:

```erb
<post>
  <id>1</id>
  <title>This is a blog post</title>
  <description> Lorem ipsum sit amet dolor...</description>
  <author>
    <authorId>2</authorId>
    <name>Stephen King</name>
  </author>
</post>
```

If we look at that, it's pretty easy to figure out what's going on,
right? When the web was first becoming more dynamic, and web
services/APIs were in their nascent stages, XML was the lingua franca of
inter-system communication. That's where **AJAX** came from:
*Asynchronous JavaScript and XML*.

So this is a `Post` instance serialized to XML. The XML describes the
state of the object, and we can find where to pull out individual bits
of data, or even reconstruct the object in memory on a new system. In
this way, XML was a great tool.

But XML had its problems as well. Just as browsers have a hard time
agreeing on how to parse tag-based HTML, parsing XML is a chore. An XML
parser has to essentially *read* through a document, finding the start
and end tags of nodes and deciding what to do with the data. Searching
XML documents with [XPATH](https://en.wikipedia.org/wiki/XPath) is
cumbersome, and constructing an XML document can be a tedious exercise
in string building and tag matching.

In addition, XML has the potential to inflate the size of the result
exponentially. Look at the `<authorId>` tag in the example above.
There's 20 bytes of metadata per one byte of data. Even in a system with
hundreds of authors, that's an inefficient way of representing things.
As the Internet grew and the demands on API speed and efficiency increased,
especially as smartphones came into play over cellular networks, the
size of the data being passed from API to consumer became *important*.

### JSON

JSON stands for "JavaScript Object Notation", and was created as a way
to use JavaScript to not only consume data from an API, but also
serialize that data for consumption. Since so much data was being used
in AJAX calls by the mid 2000s, it only made sense to start offering
that data in the native language of the calling code.

Beyond that, there's significant advantages to JSON. If we serialize
that same `Post` to JSON, it looks like this:

```javascript
{
  "id": 1,
  "title": "This is a blog post",
  "description": "Lorem ipsum sit amet dolor...",
  "author": {
    "id":2,
    "name": "Stephen King",
  }
}
```

This is still very readable, and it's easy to see what represents what,
but just in this one example we've shaved almost 50 bytes from the
string. That might not seem like much, but it's an almost 25%
improvement in size, which, when stacked up against your mobile data
plan, means 25% more times you get to obsessively check your Facebook
likes.


The other great benefit of JSON is the structure. It's just a
dictionary. A set of key-value pairs. And accessing the values of a
dictionary is *super easy* compared to traversing the nodes of a
tag-based document. We do it all the time with Ruby hashes. Not only is
it more efficient, but it's also a function that's native to the
language, rather than needing to build or use a library for parsing XML.

### Our Own JSON Serializer

So it makes sense to provide JSON to our API consumer, but we're running
a Rails app, so we need to find a way to serialize our Ruby objects to
JSON.

We need to return JSON from our controller, but it's not the
controller's *responsibility* to serialize objects, so we'll start fresh
with a new class.

Create a `app/serializers` directory, and add a `post_serializer.rb`
file to it.

**Advanced:** Rails will automatically load any code found in any
folders under `app/`, so you're encouraged to create new folders for new
types of files that aren't `models`, `views`, or `controllers`. In a
big Rails application you might find folders like `app/services`,
`app/serializers`, `app/decorators`, and others. This is just one of
many ways to keep your project organized.

Inside, we need to *serialize* a `Post` object. Again, serialization
is just turning the object into a string, in this case a JSON string. We
know how to build strings, so let's get to it.

```ruby
# serializers/post_serializer.rb
class PostSerializer
  def self.serialize(post)

    # start with the open brace to create a valid JSON object
    serialized_post = '{'

    serialized_post += '"id": ' + post.id.to_s + ', '
    serialized_post += '"title": "' + post.title + '", '
    serialized_post += '"description": "' + post.description + '", '

    # the author association can also be represented in JSON
    serialized_post += '"author": {'
    serialized_post += '"name": "' + post.author.name + '"}'

    # and end with the close brace
    serialized_post += '}'
  end
end
```

**Top-tip:** Take care with your quotations. We need to single-quote our
strings because JSON requires double-quoted keys and string values.

Now that we have our serializer, let's update our `body` action to use
it:

```ruby
# posts_controller.rb
# ...
  def body
    post = Post.find(params[:id])
    render json: PostSerializer.serialize(post)
  end
```

Note that we changed to `render json:` - we're still just rendering a
string, but we need to tell the requestor that it's a properly formatted JSON string, so that we can operate on it with JavaScript. However, it's still a plain-text string.

Now if we browse to `/posts/:id/body` (pick an `id` from the `/posts`
page), we will see our JSON!

**Top-tip:** If you haven't installed [JSONView](https://chrome.google.com/webstore/detail/jsonview/chklaanhfefbnpoihckbnefhakgolnmc?hl=en) in Chrome, now would be a great time. It helps immensely with reading your JSON and even validates it and gives you errors if there's a problem!

Now, `body` isn't really accurate anymore, since we're now returning a
serialized `Post`, so let's change the route and action to `post_data`:

```ruby
# routes.rb
# ...
  get 'posts/:id/post_data', to: 'posts#post_data'
```

```ruby
# posts_controller.rb
# ...
  def post_data
    post = Post.find(params[:id])
    render json: PostSerializer.serialize(post)
```

### Consuming JSON From The API

Now what happens if we reload our `/posts` page and try our `More`
button?

Nothing! Or, more specifically, if we look in the Chrome JavaScript
console, we'll see a `404` error because we changed the route to the
resource. So let's fix that first.

```erb
# posts/index.html.erb
# ...
<script type="text/javascript" charset="utf-8">
$(function () {
  $(".js-more").on('click', function() {
    var id = $(this).data("id");
    // change the URL to the new route
    $.get("/posts/" + id + "/post_data", function(data) {
      // Replace text of body-id div
      $("#body-" + id).text(data);
    });
  });
});
</script>
```

Okay, now if we reload and try again, we can see that our button now
replaces the truncated body with the JSON. This makes sense. Before we
were just returning a single value, but now we have a whole object. So
we'll need to alter the code to just pull the `description` from the
response JSON.

```erb
# posts/index.html.erb
# ...
<script type="text/javascript" charset="utf-8">
$(function () {
  $(".js-more").on('click', function() {
    var id = $(this).data("id");
    $.getJSON("/posts/" + id + "/post_data", function(data) {
      // Replace text of body-id div
      $("#body-" + id).html(data["description"]);
    });
  });
});
</script>
```

As you can see, we can access the JSON just like any other dictionary,
and get the value for the `"description"` key.  But first, we have to tell jQuery to expect to receive JSON data by calling `$.getJSON()` instead of `$.get()`. Otherwise, jQuery will treat `data` as a string, and `data["description"]` will return undefined.

### Using JSON To Build The Show Page

Now we want to set up our blog so that we can click a link to see the
next entry when we're reading the current one, but we don't want
to have to refresh the page.

We can reuse our `post_data` API, since that's exactly what a `Post`
show page should have on it!

We need to update the HTML part of our template with some metadata we
can use to identify the different elements, and add our `Next` link.

```erb
# posts/show.html.erb
<div class="authorName"><%= @post.author.name %></div>
<a href="#" class="js-next" data-id="<%=@post.id%>">Next...</a>
<h1 class="postTitle"><%= @post.title %></h1>
<p class="postBody"><%= @post.description %></p>
```

Note that we are using `data-id` on the `<a>`. We'll need to keep that
updated so that we know what post to request next.

Okay, now let's add the JavaScript to handle this.

```erb
# posts/show.html.erb
# ...
<script type="text/javascript" charset="utf-8">
$(function () {
  $(".js-next").on("click", function() {
    var nextId = parseInt($(".js-next").attr("data-id")) + 1;
    $.getJSON("/posts/" + nextId + "/post_data", function(data) {
      $(".authorName").text(data["author"]["name"]);
      $(".postTitle").text(data["title"]);
      $(".postBody").text(data["description"]);
      // re-set the id to current on the link
      $(".js-next").attr("data-id", data["id"]);
    });
  });
});
</script>
```

Here we grab the `data-id` attribute value, use `parseInt()` so we can
cast it and add one to it so we can request the *next* post.

After that, it's just a matter of using `$.get()` to hit our `post_data`
endpoint, and replace the `text` of each part of our show page.

If we reload and go to our first post, then click `Next`, we get that
smooth AJAX data refresh we've been looking for.

At least until we get to the last post.


## Summary

We've learned about serializing objects as strings, and the advantages
of using JSON. We've also built our own JSON serializer, and used it and
AJAX to load blog posts without reloading the page.

