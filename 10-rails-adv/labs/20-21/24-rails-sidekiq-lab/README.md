# Sidekiq Lab

## Objectives

1. Move a long-running task to Sidekiq

## Overview

In this lab, we're going to add [Sidekiq](https://github.com/mperham/sidekiq) to the song library so that we can
upload a CSV of songs and artists in a background worker.

You will find a CSV of classic rock songs and artists in `db\songs.csv`. Use it to test your work!

**Note:** This list is provided by [FiveThirtyEight](https://github.com/fivethirtyeight/data/blob/master/classic-rock/classic-rock-song-list.csv) and is available under [Creative Commons Attribution 4.0 International License](http://creativecommons.org/licenses/by/4.0/).

## Instructions

1. Use Sidekiq to process the songs csv upload with a `SongsWorker` background worker.
2. Make sure tests pass!

**Note** The sidekiq gem has been included for you in the Gemfile.
**Note** This is a working application so there are some tests intentionally passing already.

<p data-visibility='hidden'>View <a href='https://learn.co/lessons/rails-sidekiq-lab' title='Sidekiq Lab'>Sidekiq Lab</a> on Learn.co and start learning to code for free.</p>
