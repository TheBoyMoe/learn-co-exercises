## Templating and ERB

Using a templating engine like ERB allows us to create dynamic html pages - we can insert data into our template using ruby at the time the page is rendered. This data can come from the cloud, a calculation, the result of a database request, etc. Thus you can create a profile template, then populate it with individualized user data from a database.

We can use two different tags to  embed ruby in to html
  * <%= substitution tag - when we want what ever follows the tag to be rendered on the page
  * <% scripting tag - execute the ruby code that follows, nothing is rendered to the page.

Both tags are closed with %>

### Substitution tag

Evaluates any valid ruby code, renders the result to the page. We can wrap substitution tags in html tags, e.g.

```text
  <h1><%= 'I love' + ' ruby!' %></h1> => <h1>I love ruby</h1>
```

### Scripting tags

Scripting tags are most commonly used for embedding loops or conditional logic in to a template

```html
  <% if logged_in? %>
    <a href="/logout">Click here to Log Out</a>
  <% else %>
    <a href="/login">Click here to Log In</a>
  <% end %>
```  

Iterating over an array, we use the substitution tag to display the value of the inner square variable

```html
  <ul>
    <% squares = [1, 4, 9, 16] %>
    <% squares.each do |square| %>
      <li><%= square %></li>
    <% end %>
  </ul>
```

```html
  <ul>
    <li>1</li>
    <li>4</li>
    <li>9</li>
    <li>16</li>
  </ul>
```

If you wanted to display a list of posts, the following code added to your erb template

```html
  <% wall_posts = ["First post!", "Second post!", "Hello, it's your mother. Why don't you ever call me?"] %>
  <ul>
    <% wall_posts.each do |post| %>
      <li><%= post %></li>
    <% end %>
  </ul>
```

would render as:

```html
  <ul>
    <li>First Post!</li>
    <li>Second Post!</li>
    <li>Hello, it's your mother. Why don't you ever call me?</li>
  </ul>
```



### Resources
1. [Introduction to ERB Templating](http://www.stuartellis.name/articles/erb/)
