## Objectives

  1. Understand the concept of AR Lifecycle methods
  2. Use `before_save`, `before_create`, and `before_validation`
  3. Understand when to use `before_validation` vs. `before_save`

## Callbacks

Now that you are integrating ActiveRecord into Rails, we must first have a quick discussion about how developers can control the "lifecycle" of our object. This means that it can be nice to inject our code every time ActiveRecord does something to our model. There are a ton of different places we can inject our code. In this reading we are going to discuss the most common ones. Before we begin, some quick terminology. Everything we cover here is called "Active Record Lifecycle Callbacks". Many people just call them callbacks. It's a bit shorter.

Take a look at the blog app that is included. It's pretty simple. We have a `Post` model and a few views. The `Post` `belongs_to` an `Author`. Also in the `Post` model you'll notice a validation to make sure that post titles are in title case. Title case means every word starts with a capital letter.

While this validation is great, there is a method provided by Rails called `#titlecase` that will do this for us. I still want this validation, but let's make it so that just automatically before we save the record it runs `#titlecase`. What a convenience we are providing to our users! We are going to use our first callback, `before_save`. We use this similar to how you use `has_many` or `validates`. They are at the top of your model files. First let's write our method to actually run the `#titlecase` method.

```ruby
# post.rb

  def make_title_case
    self.title = self.title.titlecase
  end
```

Ok, now we want to run this whenever someone tries to save to the database. This is where the `before_save` comes:

```ruby
class Post < ActiveRecord::Base

  belongs_to :author
  validate :is_title_case

# New Code!!
  before_save :make_title_case

  private

  def is_title_case
    if title.split.any?{|w|w[0].upcase != w[0]}
      errors.add(:title, "Title must be in title case")
    end
  end

  def make_title_case
    self.title = self.title.titlecase
  end
end
```

This shouldn't look too alien! Pretty much whenever you persist to the database (so `#save` and `#create`) this code will get run. Let's open up the console (`rails c`) and test it out:

```ruby
p = Post.create(title: "testing")
#   (0.1ms)  begin transaction
#   (0.1ms)  rollback transaction
# => #<Post id: nil, title: "testing", description: nil, created_at: nil, updated_at: nil, post_status: nil, author_id: nil>
```

Wait! There was no `INSERT` SQL command issued. In fact, we see the `rollback transaction` line. That means that it didn't actually save to the database. If we do `p.valid?` right now it will return `false`. That's not right. We automatically title case things. The validation should pass! Then after reading much documentation, it turns out that the `before_save` is called **after** validation occurs. So Rails goes `is valid?` "Nope! Stop!", and never makes it to `before_save`. Let's change our callback to the `before_validation` callback. This one happens **before** validation. That means that first our `before_validation` code works, which title cases the title, *then* the validation runs, which passes! Here is the final code:

```ruby
class Post < ActiveRecord::Base

  belongs_to :author
  validate :is_title_case

# New Code!!
  before_validation :make_title_case

  private

  def is_title_case
    if title.split.any?{|w|w[0].upcase != w[0]}
      errors.add(:title, "Title must be in title case")
    end
  end

  def make_title_case
    self.title = self.title.titlecase
  end
end
```

Here is a rule of thumb: **Whenever you are modifying an attribute of the model, use `before_validation`. If you are doing some other action, then use `before_save`.**

### Before Save

Now let's do something that belongs in the `before_save`. We use `before_save` for actions that need to occur that aren't modifying the model itself. For example, whenever you save to the database, let's send an email to the Author alerting them that the post was just saved!

This is a perfect `before_save` action. It doesn't modify the model so there is no validation weirdness, and we don't want to email the user if the Post is invalid. That would be just mean! So if you had some method called `email_author_about_post` you would modify your `Post` model to look like this:


```ruby
class Post < ActiveRecord::Base

  belongs_to :author
  validate :is_title_case

  before_validation :make_title_case

# New Code!!
  before_save :email_author_about_post

  private

  def is_title_case
    if title.split.any?{|w|w[0].upcase != w[0]}
      errors.add(:title, "Title must be in title case")
    end
  end

  def make_title_case
    self.title = self.title.titlecase
  end
end
```

### Before Create

Before you move on, let's cover one last callback that is super useful. This one is called `before_create`. `before_create` is very close to `before_save` with one major difference: it only gets called when a model is created for the first time. This means not every time the object is persisted, just when it is **new**.

For more information on all of the callbacks available to you, check out [this amazing rails guide](http://guides.rubyonrails.org/active_record_callbacks.html).
