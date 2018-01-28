## DELETE Forms and Requests

### Objectives

1. Draw a `delete` route mapping to a `#destroy()` action
2. Use `form_tag` to build a delete form for an object
3. Build a `#destroy()` action that finds the instance, destroys it, and redirects to the `index` action
4. Use `link_to` and `button_to :method => :delete` to destroy an object without a form



1. Create a delete route 

```ruby
# config/routes.rb

delete 'people/:id', to: 'people#destroy'
```

2. Create a form_tag to delete the object

```erb
# app/views/people/show.html.erb

<h2><%= @person.name %></h2>
<%= @person.email %>
<%= form_tag people_path(@person.id), method: "delete" %>
  <%= submit_tag "Delete #{@person.name}" %>
<% end %>
```

Returns the following html

```html
<h2>Caligula</h2>
caligula@rome-circa-40-AD.com
<form accept-charset="UTF-8" action="/people/1" method="post">
  <input name="_method" type="hidden" value="delete" />
  <input name="utf8" type="hidden" value="&#x2713;" />
  <input name="authenticity_token" type="hidden" value="f755bb0ed134b76c432144748a6d4b7a7ddf2b71" />
  <input name="commit" type="submit" value="Delete Caligula" />
</form>
```


As of HTML5, forms officially do not support `DELETE` and `PATCH` for their methods. What you're seeing in the above `#form_tag()` behavior is a **workaround** implemented for us by Rails itself. 


3. Controller #delete action


```ruby
# app/controllers/people_controller.rb

  def destroy
    Person.find(params[:id]).destroy
    redirect_to people_path
  end
```


4. Or use Rails's JavaScript Helper



```erb
<!-- app/views/people/index.html.erb //-->

<% @people.each do |person| %>
<div class="person">
  <span><%= person.name %></span>
  <%= link_to "Delete", person, method: :delete, data: { confirm: "Really?" } %>
</div>
<% end %>
```

[`link_to`](http://api.rubyonrails.org/classes/ActionView/Helpers/UrlHelper.html#method-i-link_to) is a method of `UrlHelper` that has a number of convenient features.

The HTML generated by that call to `link_to` looks like this:

```html
<a data-confirm="Really?" rel="nofollow" data-method="delete" href="/people/1">Delete</a>
```

The `data-confirm` attribute and the `data-method` attribute rely on some JavaScript built into Rails.

`data-method` will "submit" a `DELETE` request as if a form had been submitted. It will use `GET` (the default method used by all browsers for HTML links) if the user has JavaScript disabled.

`data-confirm` pops up a confirmation window before the link is followed.