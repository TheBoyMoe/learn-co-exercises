# Authorization with CancanCan

## Objectives
1. Understand how to create an Ability class.
2. Learn how to model permissions in the database.
3. Prevent users from accessing certain actions from the controller.
4. Prevent users from seeing certain pieces of the view.

## Overview

We have been looking at different modes of authentication. Now, we'll shift our focus, and start dealing with authorization: how do you describe a permissions model, and how do you implement it in Rails?

(Also, in case you were wondering, standard UNIX permissions let you delete a file you don't own and can't write to. You must, however, be able to write to the directory that contains the file.)

## CancanCan

[CanCanCan] is a gem for Rails that provides a simple but quite flexible way to authorize users to perform actions.  It's the continuation of a no longer maintained gem [CanCan](https://github.com/ryanb/cancan).

In your controllers, it looks like this:
```ruby
    def show
      @article = Article.find(params[:id])
      authorize! :read, @article
    end
```
Here we're calling CanCanCan's `authorize!` method to determine if the user can `:read` this `@article`. If they can't, an exception is thrown.

Setting this for every action can be tedious. Therefore, the load_and_authorize_resource method is provided to automatically authorize all actions in a controller. It will use a before filter to load the resource into an instance variable and authorize it for every action.

```ruby
class ArticlesController < ApplicationController
  load_and_authorize_resource

  def show
    # @article is already loaded and authorized
  end
end
```

##Handling Unauthorized Access

If the user authorization fails, a CanCan::AccessDenied exception will be raised. You can catch this and modify its behavior in the ApplicationController.

```ruby
class ApplicationController < ActionController::Base
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end
end
```

In your views, it might look like this:
```erb
    <% if can? :update, @article %>
      <%= link_to "Edit", edit_article_path(@article) %>
    <% end %>
```
Or maybe this:
```erb
   <% if cannot? :update, @article %>
     Editing disabled.
   <% end %>
```

##Abilities
To generate the ability file you can run `rails g cancan:ability`

This creates an `ability.rb` file in your `models` directory with an `Ability` class inside.

To define the permissions, you fill out the `Ability` class, which goes a bit like this:
```ruby
    class Ability
      include CanCan::Ability

      def initialize(user)
        if user.admin?
          # only admins can change things
          can :update, Article
        end
        # but anyone can read them
        can :read, Article
      end
    end
```
Your `Ability` class is passed an instance of your `User` model by calling the current_user method. In the initializer, you call `can` or `cannot` to define what this particular user can do.

`can` and `cannot` both take these arguments:
--the action, written as a symbol 
--an ActiveRecord class, an instance of which is the target of the action. 

You can be more specific if you want to allow or disallow actions based on information in the models. For example,
```ruby
    can :write, Article, owner_id: user.id
```
This will let the user write any article whose `owner_id` is her user id. (That is, any Article she owns).
```ruby
    can :read, Article, :category => { :visible => true }
```
This will let the user `:read` any `Article` whose `category`'s `visible` column is `true`.

CanCanCan doesn't make any assumptions about how you've stored permission information in your user model. It's up to you to add the appropriate fields to support your authorization scheme.

## A simple scheme

Here is a basic CanCanCan Ability class for a message board.

The rules are: anyone can post. Registered users can edit their post after posting (but not delete it). Moderators can do anything to any post.
```ruby
    class Ability
      include CanCan::Ability

      def initialize(user)
        can :read, Post
      	can :create, Post
        unless user.nil? # guest
          # CanCan accepts a hash of conditions;
          # here, we're saying that the Post's user_id
          # needs to match the requesting User's id
      	  can :update, Post, { user_id: user.id }
      	end
      	if user.admin?
      	  can :manage, Post
      	end
      end
    end
```
`:manage` is a special CanCanCan action which means "any action". So users with an admin column set to `true` can do anything to any Post.

## Video Review

* [Building Authorization and Metaprogramming](https://www.youtube.com/watch?v=wsbfUc-CPbg) 

## Resources
  * [CanCanCan](https://github.com/CanCanCommunity/cancancan)
