## Using a Layout Template

Many pages of a site will share the same navigation, sidebar and footer. To avoid copy and pasting the same code to multiple template files - not to mention the headache of having to change one of these, we can create a single, 'layout.erb', file which contains all of the code common to all pages.

Create a 'layout.erb' file that has the code which is consistent between pages, e.g. the header and footer. Add the 'yield' keyword to the template where we would like the templating engine to insert the code that will change from page to page. When a controller is called it will look for a 'layout.erb' file. If it finds one, it will automatically insert it's template content into that of the layout in the position of the 'yield' keyword.

```html
  # layout.erb
  <!doctype html>
  <html>
    <head>
      <title>Cats</title>
      <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
      <link rel="stylesheet" href="/css/style.css">
    </head>
    <body>

      <div class="container">
        <h1>I love cats</h1>
        <img src="https://s3.amazonaws.com/after-school-assets/cat-typing.gif">

        <!-- content of 'index.erb' will be inserted here -->
        <%= yield %>

      </div>
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
      <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
    </body>
  </html>
```

```ruby
  # controller
  get '/' do
    erb :index
  end
```

```html
  # index.erb
  <h2>This cat...</h2>
  <img src="https://s3.amazonaws.com/after-school-assets/cat.gif">
```
