# Uploading Images With Paperclip Lab

## Objectives

1. Use Paperclip to add an image attachment to a model.
2. Set default images when avatars aren't there.
3. Post-process avatars to create thumbnails of avatars.

## Song Library

In this lab, we're going to augment our song library to upload album
cover art and display them with songs.

When we list songs, we want to show an album cover thumbnail, but when
we're on the song's page, we'd like to see the full-size image. We also
want it to still look good if we haven't uploaded cover art yet.

## Instructions

The base models, controllers, views and other files have been provided. There's seed data to get you started, and there are tests for the lab in the `spec` directory.

Since we are adding new features to an existing application, there will
already be some passing tests. Part of your job is to make sure they're
still passing after you're done!

1. Use Paperclip to add an `album_cover` attachment to songs. Create a
   `:thumb` style for image thumbnails, set a default image of your
choosing, and set up the new and edit song pages to do the image upload.
2. Display the thumbnail image with the song in the song index, and
   display the full-size image on the song show page.
3. Make sure all tests pass then do this:

![Prancing Homer](http://i.giphy.com/kEKcOWl8RMLde.gif)
