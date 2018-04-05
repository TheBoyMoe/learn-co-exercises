# Administration With ActiveAdmin

## Objectives

1. Use the ActiveAdmin gem to add admin features to the blog app.
2. Customize the ActiveAdmin resource to prevent certain actions and
   hide form fields.

## Lesson

We're going to use [ActiveAdmin](https://github.com/activeadmin/activeadmin) to add administrative features to our blog application. Not anyone should just be able to come in and create a new `author` on our blog. That's something only an admin should do.

Our app already has [Devise](https://github.com/plataformatec/devise) set up for user management. We're going to leave our main blog pages open to the public and only password-protect the ActiveAdmin parts.

### Setting Up ActiveAdmin

To get started, let's add ActiveAdmin to our Gemfile:

`gem 'activeadmin', github: 'activeadmin'`

We need the `github: 'activeadmin'` part to use the latest under-development version, which is compatible with Rails 4.2.

Then run `bundle install`.

**Note:** We're going to follow along with the [github docs](https://github.com/activeadmin/activeadmin/blob/master/docs/0-installation.md), because the ActiveAdmin website is out-of-date.

Now we generate the ActiveAdmin installation with `rails g active_admin:install`. This will create a migration for an `AdminUser` model, add a default user to our `seeds.rb` file, and generate the base ActiveAdmin files.

Let's run `rake db:migrate` then `rake db:seed` to finish the setup.

Finally, restart your Rails server, then browse to `http://localhost:3000/admin`.

We have a login page! Log in as `admin@example.com` with password `password` and you'll be on the ActiveAdmin dashboard.

**Top-tip:** You can change the login and password in `seeds.rb` before migrating, or even better, log in and change the login/password from within the app to make it more secure.

### Registering Models

Okay, we have a dashboard, but there's not much to do. That's because we haven't registered any models yet.

Let's set this up to administer `authors`.

`rails generate active_admin:resource Author`

This will create a new file at `app/admin/author.rb`. We're not even gonna look at it yet. Trust me. Look away!

![look away](http://i.giphy.com/w28gdjyOPemd2.gif)

Just reload `/admin` and you should see a new item in the top bar for `Authors`. Click it. You can add new authors, edit and delete existing ones, all from a single command and no code!

![joey shock](http://i.giphy.com/ccosx2jCejdew.gif)

### Customizing ActiveAdmin Resources

Out of the box it's incredibly easy to set up ActiveAdmin to provide admin features. But you might want to give some restrictions to what it can do.

First, let's prevent authors from being deleted, even by ActiveAdmin. *Now* you can look at `app/admin/author.rb`.

We want to make sure we're set up to use Strong Params to only allow certain fields, so let's set that up:

```ruby
# admin/author.rb

ActiveAdmin.register Author do
    permit_params :name, :genre
end
```

**Note:** In some instances, you will be required to set `permit_params` even if you don't want to change any of them from the default. If you receive an `ActiveModel::ForbiddenAttributes` exception when working with ActiveAdmin, set up those `permit_params`.

Now we're only allowing `name` and `genre` to be set.

By default, all CRUD actions are available to an ActiveAdmin resource. But we can change that:

```ruby
# admin/author.rb

ActiveAdmin.register Author do

  permit_params :name, :genre
  actions :all, except: [:destroy]

end
```

If we refresh the authors admin page, the "Delete" link is now gone.

If we want to edit the elements on the form, and remove `bio` so that the form matches our `permit_params`, we can override the default form:

```ruby
# admin/author.rb

  permit_params :name, :genre
  actions :all, except: [:destroy]

  form do |f|
    inputs 'Author' do
      f.input :name
      f.input :genre
    end
    f.semantic_errors
    f.actions
  end
```

Reload again and bio is gone. This `form do ... end` block uses an ActiveAdmin domain-specific language (DSL) to manipulate a [Formtastic](https://github.com/justinfrench/formtastic) form. Removing it completely returns the form to the default.

**Advanced:** You might be tempted to think of `admin/author.rb` as if it were a kind of model, but as you can see, it controls all aspects of an ActiveAdmin resource, including both business logic and presentation logic. One could make the argument that this is a violation of Separation of Concerns, but in Rails a "resource" is a concept that comprises model, controller, and view, so in that sense, an ActiveAdmin's resource is concerned with all aspects of that resource. In any case, it's easy to find where the code goes.

## Summary

We've seen how easy it is to use ActiveAdmin to quickly add administration to our app, and how to do some basic customization. More configuration options are available and can be found in the docs, but I think we can all agree that the default options are very helpful and easy to use.

![friends clap](http://i.giphy.com/lI6nHr5hWXlu0.gif)
