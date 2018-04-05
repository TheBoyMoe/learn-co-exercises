# Long-Running Tasks Lab

## Objectives

1. Create a long-running task.
2. Upload and process a CSV file to create songs.

## Overview

In this lab, we're going to augment the song library so that we can
upload a CSV of songs and artists to expand our collection.

You will find a CSV of classic rock songs and artists in `db\songs.csv`. Use it to test your work!

**Note:** This list is provided by [FiveThirtyEight](https://github.com/fivethirtyeight/data/blob/master/classic-rock/classic-rock-song-list.csv) and is available under [Creative Commons Attribution 4.0 International License](http://creativecommons.org/licenses/by/4.0/).

## Instructions

1. Update the songs index page to allow a CSV file upload of songs with
   artist names. In an `songs_controller#upload` action, create `Song` and `Artist` records from the CSV and
redirect to the songs index page.
2. Make sure tests pass!

**Note** We're editing an existing application with some intentionally passing tests.  
