# Long-Running Tasks In Rails

# Objectives

1. Create a long-running task and observe its impact on the user
   experience.

# Lesson

Most of the things we do in Rails apps revolve around simple tasks that affect only one or a few database objects at a time, and are handled in milliseconds, quickly enough that the impact on the request/response time of our pages is minimal.

Sometimes, however, we need to do something that takes longer to do and heavily impacts page load time, like sending a bunch of emails, uploading large files, manipulating a lot of records, or generating a report. Let's look at how that might happen.

## Importing Records From CSV

A common task in many systems is importing records from a Comma-Separated Value (CSV) file. You might need to do this for any number of reasons, from seeding a new database to integrating and sharing data from another system.

Attached is a very simple "customer database" app. It has a list of all customers at `/customers`.

Our sales team has just aquired some hot leads and wants them in the system right away.

![put that coffee down](http://i.giphy.com/MSixuOOVyQbF6.gif)

Turns out we'll be getting new leads via a CSV every week, so instead of importing them manually, we'll just build a feature where the sales team can do it themselves.

We'll let them do the import right from the customers `index`, so let's just add a route to take the file upload:

```ruby
# config\routes.rb

  resources :customers, only: [:index]
  post 'customers/upload', to: 'customers#upload'
```

Then let's add the controls to upload a file to our `index` view:

```erb
# views\customers\index.html.erb

<h1>Our Customers</h1>
<%= form_tag customers_upload_path, multipart: true do %>
  <%= file_field_tag :leads %>
  <%= submit_tag "Import Leads" %>
<% end %>
<ul>
<% @customers.each do |customer| %>
# ...
```

Finally, let's get into our controller and handle this file upload.

To do that, we first need to examine the file. Check out `db/customers.csv`. The first row defines the fields, and isn't part of the dataset, so that's called a `header`. 

Each row is ordinal, like an array, so position 0 is email, position 1 is first name, and position 2 is last name.

Armed with all that, we can build our controller method:

```ruby
# controllers\customers_controller.rb

class CustomersController < ApplicationController
  require 'csv'

  def index
    @customers = Customer.all
  end

  def upload
    CSV.foreach(params[:leads].path, headers: true) do |lead|
      Customer.create(email: lead[0], first_name: lead[1], last_name: lead[2])
    end
    redirect_to customers_path
  end

end
```

**Note:** We're using the `CSV` library (`require 'csv'`), which is a standard Ruby library, to do the processing. You can learn more about it [here](http://ruby-doc.org/stdlib-1.9.3/libdoc/csv/rdoc/CSV.html)

Okay, let's reload `/customers`, select `customers.csv` from our project's `db` directory, and click go.

Wait for it.

![wait for it](http://i.giphy.com/xf20D8HzvTQzu.gif)

Keep waiting.

Okay, eventually, the page should refresh and we'll see our new customers. Depending on the speed of your computer, it might have taken upwards of a full minute for 25,000 rows. 25,000 might seem like a lot, but systems routinely process millions and millions of rows of data every day.

## Summary

We've seen how something as straightforward as creating records from a data file can take almost a minute for your server to process and reload a page. And while a minute might seem pretty fast to create 25K records, consider it from the standpoint of the user. Even as developers who know how long things take, if we have to wait more than a couple seconds for a page to load, we get frustrated, so clearly this isn't a great experience.

But at least you have time for that coffee now.

![that's good coffee](http://i.giphy.com/dGhlifOCTtSdW.gif)

<p data-visibility='hidden'>View <a href='https://learn.co/lessons/rails-long-running-tasks-readme'>Long Running Tasks in Rails</a> on Learn.co and start learning to code for free.</p>
