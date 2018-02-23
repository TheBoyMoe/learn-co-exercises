# CancanCan Secret Notes

## Objectives
1. Understand how to create an Ability class.
2. Learn how to model permissions in the database.
3. Prevent users from accessing certain actions from the controller.
4. Prevent users from seeing certain pieces of the view.

## Overview

We're going to learn how to integrate [CanCanCan] into a Rails application. Our authorization model for this example will be a message board for secret notes.

## Instructions

1. Create a `User` model and migration. `User`s have `name`s and that's it.

We could give our users passwords quite easily with `has_secure_password`. However that would make it a lot more annoying to develop this app! For now, we'll just have usernames, and we'll let anyone sign in as someone else only using their name. This will make it easy to switch between accounts and test our authorization scheme.

2. Create a `Note` model. `Note`s have `content`, and a `user`, their creator.

3. Create a `Viewer` model. `viewers` is a join between `notes` and `users`. An entry in the `Viewer`s table means that `user` can view that `note`.

Hint: There are a few ways to set up the relationship between `Note`s and `User`s. Here's what the tests expect:

    # user.rb
    has_many :viewers
    has_many :readable, through: :viewers, source: :note

    # note.rb
    has_many :viewers
    has_many :readers, through: :viewers, source: :user

When we create a new note, we'll want a form that takes in a comma-separated list of usernames which represent who that note is visible to.  We'll use utility methods on the note model which should know how to create the relationship between a note and its viewers.  These readers and writers will be called `visible_to` and `visible_to=`.  You should be able to use the same principles of mass assignment and "accepts_nested_attributes" to accomplish this.  Use the tests as your guide.

4. Create controllers. We'll need a `SessionsController`, a `UsersController`, and a `NotesController`. `UsersController` just needs a `create` route. `NotesController` should have the full CRUD suite.  Your `SessionsController` will be logging in and out users using the principles we learned earlier in this unit (but we won't use a password only a username).  

5. Add [CanCanCan] to your Gemfile.
6. Generate a skeleton `Ability` model with `rails g cancan:ability`. Write rules in the `Ability` model. If you need help on composing rules, [the documentation here][defining_abilities] is good.

The rules are a little bit tricky because you have to look through an association to figure out if a user can read a note. You'll want to use a block condition, like this:

    can :read, Note do |note|
      # TODO
    end

If your ActiveRecord relationships have been set up right, this should be fine.

Now, go through the remaining tests and ensure they pass. To pass the controller tests, make calls to `authorize!` or `load_and_authorize_resource` in your `NotesController`.

[CanCanCan]: https://github.com/CanCanCommunity/cancancan
[defining_abilities]: https://github.com/CanCanCommunity/cancancan/wiki/defining-abilities

    can :read, Note do |note|
      # TODO
    end

## Resources
[Sitepoint - CanCanCan: The Rails Authorization Dance](http://www.sitepoint.com/cancancan-rails-authorization-dance/)

<p data-visibility='hidden'>View <a href='https://learn.co/lessons/cancan_lab'>Cancan Lab</a> on Learn.co and start learning to code for free.</p>
