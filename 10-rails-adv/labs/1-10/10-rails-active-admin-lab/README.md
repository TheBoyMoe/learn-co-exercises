# Long-Running Tasks Lab

## Objectives

1. Add ActiveAdmin to the song library to manage artists and songs.
2. Customize ActiveAdmin to disallow deleting artists.
3. Remove routes to prevent non-admins from creating and editing artists
   and songs.

## Overview

In this lab, we're going to use ActiveAdmin to add administrative
features to the song library so that we can control access and prevent
non-admins from adding and editing songs and artists.

## Instructions

The basic app has been set up with Devise as a starting point.

1. Install and configure ActiveAdmin with the default AdminUser.
2. Configure ActiveAdmin to allow full management of songs, and allow
   everything except `delete` for artists. **Hint:** Also make sure you
remove any defunct `link_to`s from your views.
3. Remove the ability to create, destroy, and edit songs and artists outside of
   ActiveAdmin
4. Make sure tests pass!
