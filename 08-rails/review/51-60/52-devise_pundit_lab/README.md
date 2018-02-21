# Devise and Pundit Lab

## Objectives

We're going to learn how to integrate Pundit into a Rails application.
For our data model, we're going to return to our secret notes message board.

## Data model

We're going to have Users, Notes, and a viewers join table, which gives users read access to notes.

## Instructions

The lab comes with a Rails skeleton with Devise installed.

1. Add a role enum to the user model.
2. Write a policy governing the User model. Ensure all policy specs pass.
3. Add authentication and authorization filters to your users controller. Ensure that only administrators can update or destroy users.

We've included the relevant models/controllers and views from the CanCanCan lab
so you don't have to rebuild them.  The data model is exactly the same, the only
difference is that we're using Roles and Pundit to authorize actions rather than
[CanCanCan].

# Note
If you launch the app in the browser in its starting state it will throw an error. This occurs because
certain things the code depends on, like `current_user`, are no longer functional.
You'll need to start implementing devise to boot the app up in the browser.
Follow the tests.

**Hints**
* Some tests might require you adding the flash to a layout.
* If you use all the devise modules you will run into problems.
  Figure out which ones you need and include only those modules.

Using the User policy as a guide, write a spec for the NotePolicy class, then
write the NotePolicy class. You should ensure that:

  * Normal users can:
    * Create notes owned by them
    * Edit their own posts
    * Delete their own posts
    * Add viewers to their own posts
    * Remove viewers from their own posts
    * See notes they're viewers of
    * See their own notes
  * Moderators can:
    * See all notes.
  * Admins can:
    * Perform any action on a user or a note.

Once your policy spec is written and passes, write feature specs for creating, reading, and updating notes. You can copy the feature specs that currently exist for updating and deleting users.

## References
* [Pundit]

[Pundit]: https://github.com/elabs/pundit
[CanCanCan]: https://github.com/CanCanCommunity/cancancan

<p data-visibility='hidden'>View <a href='https://learn.co/lessons/devise_pundit_lab' title='Devise and Pundit Lab'>Devise and Pundit Lab</a> on Learn.co and start learning to code for free.</p>
