# Uploading Images with Paperclip

## Objectives

1. Use the Paperclip gem to upload photos as attachments to models.
2. Use a default image when nothing has been attached.
3. Understand image processing and resizing with Paperclip.

## Lesson

We're going to be using the Paperclip gem to add author pictures to our blog application so that readers can match a face to a post. Make sure to run `rake db:seed` to set up some test data!

### Setting Up Paperclip

In our blog application, we want to be able to show the author's headshot, so we're going to turn to the popular gem [Paperclip](https://github.com/thoughtbot/paperclip) to help us out. We could certainly write our own code to handle the image uploads, but as we'll see, Paperclip offers so much in terms of integrating with our ActiveRecord models, configuring storage options, and processing images after upload.

To set up Paperclip, first we need to install the [ImageMagick](http://www.imagemagick.org/script/index.php) dependency. Paperclip uses ImageMagick to resize images after upload.

On OS X, the preferred way to install ImageMagick is with [Homebrew](http://brew.sh/):

`brew install imagemagick`

On Linux, use `apt-get`:

`sudo apt-get install imagemagick -y`

If you are using another system, you can get download and install instructions from the [ImageMagick website](http://www.imagemagick.org/script/binary-releases.php).

Once we have ImageMagick, let's add Paperclip to our Gemfile:

```ruby
# Gemfile

#...
gem "paperclip"
```

Run `bundle install` to finish it up. If your Rails server is already running, remember to restart it so that it has access to the new gem.

### Adding An Avatar To An Author

Now that we have Paperclip installed, let's jump right into adding avatar images to our `Author` model.

First, we need to wire up our model to use Paperclip's `has_attached_file` method, and tell it what attribute name we want to use to access the attached file. In this case, we'll go with `avatar`.

```ruby
# models/author.rb

class Author < ActiveRecord::Base
  has_many :posts
  has_attached_file :avatar
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
end
 ```

The `validates_attachment_content_type` validator is provided by Paperclip, and ensures that we get an image file when we expect one. This validator is required by default.

Now we need to add the `avatar` field to our table via a migration. Paperclip provides a generator for us, so we can run:

`rails g paperclip author avatar`

This will generate a migration that looks something like:

```ruby
class AddAttachmentAvatarToAuthors < ActiveRecord::Migration
  def self.up
    change_table :authors do |t|
      t.attachment :avatar
    end
  end

  def self.down
    remove_attachment :authors, :avatar
  end
end
```

**Note:** Paperclip provides two new methods for use in migrations: `add_attachment` and `remove_attachment`. Because these are custom attachment methods, Rails won't know how to automatically reverse an `add_attachment` migration, so you need `up` and `down` methods in the migration rather than simply using `change`.

Run `rake db:migrate` to add the column.

Now we need to set up the form view to give us a way to upload an avatar. Let's add that to the author form partial:

```erb
# views/authors/_form.html.erb

<%= form_for @author, html: {multipart: true} do |f| %>
  <%= f.label :avatar %>
  <%= f.file_field :avatar %><br>
  <%= f.label :name %>
  <%= f.text_field :name %><br>
  <%= f.label :bio %>
  <%= f.text_area :bio %>
  <%= f.submit %>
<% end %>
```

Adding `html: { multipart: true }` as a parameter to `form_for` will generate a form that knows it will be submitting both text and binary data to the server. Then we use the `file_field` helper to generate the appropriate input and "choose" button to attach the file.

Finally, we need to update our strong params in the controller to allow the new `avatar` field to be used for mass assignment:

```ruby
# authors_controller.rb

# ...

  private

  def author_params
    params.require(:author).permit(:bio, :name, :avatar)
  end
```

Now if we run our server with `rails s` and browse to `/authors/new`, we should be able to create an author with an avatar.

### Displaying The Avatar

We've attached the avatar, but now we need to display it to the user. Here's where Paperclip really starts to shine.

Let's add the avatar to our author `show` view:

```erb
# views/authors/show.html.erb

<h1><%= @author.name %></h1>
<%= image_tag @author.avatar.url %>
<p><%= @author.bio %></p>
<p>Posts:</p>
# ...
```

Simple as that! Paperclip provides the `url` method on our `avatar` so that no matter where it's stored, we can always use it in an `image_tag`. Now we're starting to see why using Paperclip is more efficient than doing it ourselves.

Let's also add the avatar to the author `index` view, so we can see them in the list.

```erb
# views/authors/index.html.erb

#...
  <% @authors.each do |author| %>
    <li>
    <%= image_tag author.avatar.url %>
    <%= link_to author.name, author_path(author) %><br>
    <%= author.bio %>
    </li>
  <% end %>
#...
```

Now if we load `/authors`, we'll see avatars. Unless they don't have one. Now what?

### Setting Default Avatars

In another stroke of awesomeness, Paperclip gives us an elegant way of dealing with missing avatars that doesn't involve us having to go into every view that displays an avatar and write a bunch of logic.

Let's go back to our model and tell `has_attached_file` what the default is when no file has been attached:

```ruby
# author.rb

class Author < ActiveRecord::Base
  has_many :posts
  has_attached_file :avatar, default_url: ':style/default.png'
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
end
```

You can store default images to match each style, e.g. in this case we would have a thumbnail default as well as an original default. You just need the supporting folders in your `app/assets/images` directory to match the style names ("original" is the default, unprocessed style).

**Note:** We have to place an image named `default.png` in our `app/assets/images/thumb` and `app/assets/images/original` folders (already provided), that part doesn't automatically happen via Paperclip (Image)Magick.

Reload `/authors`. No more broken images!

### Generating Thumbnails With Paperclip

Depending on how big an author's photo is, our `index` page might have wildly different-sized images in the list.

We can easily constrain those with CSS, but what we really want to do is create a thumbnail to be used in the list so we aren't loading a bunch of giant images and slowing things down.

In order to do this, we're going to have to write a lot of low-level code using ImageMagick to process the avatar.

![wait what](http://i.giphy.com/fNkhImNAjA5FK.gif)

Kidding! Of course Paperclip already does this for us! Let's get back into our `Author`.

```ruby
# author.rb

class Author < ActiveRecord::Base
  has_many :posts
  has_attached_file :avatar, default_url: ':style/default.png', styles: { thumb: "100x100>" }
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
end
```

And just like that, Paperclip will process the image and create a thumbnail style for us. To use it in the view, simply pass the symbol for the style to the `url` method:

```erb
# views/authors/index.html.erb

#...
  <% @authors.each do |author| %>
    <li>
    <% image_tag author.avatar.url(:thumb) %>
    <%= link_to author.name, author_path(author) %><br>
    <%= author.bio %>
    </li>
  <% end %>
#...
```

If we go to `/authors/new` and create an author, then return to `/authors`, we'll see that the thumbnail has been generated for the new author, but now one or more of our existing author's thumbnails is a broken image.

That's because we added images to those authors before we defined the `:thumb` style, so we need to tell Paperclip to update our existing images with the new style. Fortunately, Paperclip provides a rake task for exactly
that.

In the terminal, run `rake paperclip:refresh:missing_styles`, then refresh that `/authors` page and we should have thumbnails for everyone.

## Summary

We've seen how easy it is to upload image attachments, have default avatars, and create thumbnails in our application with very little code thanks to the Paperclip gem.

