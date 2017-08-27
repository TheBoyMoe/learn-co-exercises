### Active Record Associations

Active record associations allows you to create the has-many/belong-to and the many-to-many or has-many-through relationships between your classes/models with very little code. Active record facilitates the creation of the following relationships between models:
 * belongs_to
 * has_one
 * has-many
 * has_many :through
 * has_one :through
 * has_and_belongs_to_many

Building these relationships, we need to:
 * write a migrations that create tables with associations, e.g. if a song belongs to an artist, add an artist_id column to the songs table, and
 * use ActiveRecord macros in the models to create the relationships.


### A Worked Example

Using the example of artists, songs and genres, we can enact the following relationships:
  * an artist has many songs and a song belongs to an artist.
  * a genre has many songs and a song belongs to a genre.
  * artists have many genres through songs.
  * a genre has many artists through songs.

#### Song Model

A song belongs to both an artist and a genre, and so will need an artist_id and genre_id columns. These foreign keys, in conjunction with ActiveRecord macros will enable the creation of the has_many, belongs_to and has_many :through relationships. This will allow us to retrieve an artist's songs or genres, a song's artist or genre, and a genre's songs and artists.

The songs table acts as a joins table, connecting the artists and genres tables through the foreign keys, artist_id and genre_id. The relationships we'll create through ActiveRecord macros. This means that a song can have many genres through songs and a genre can have many artists through songs - creating a many-to-many relationship. Migration for the songs table:

```ruby
  class CreateSongs < ActiveRecord::Migration
    def change
      create_table :songs do |t|
        t.string :name
        t.integer :artist_id
        t.integer :genre_id
      end
    end
  end
```

#### Artist Model

An artist will have many songs and it will have many genres through songs. These associations will be taken care of entirely through ActiveRecord macros. The Artist model requires only two column, id and name.

```ruby
  class CreateArtists < ActiveRecord::Migration
    def change
      create_table :artists do |t|
        t.string :name
      end
    end
  end
```

#### Genre Model

A genre will have many songs and it will have many artists through songs. These associations will be taken care of entirely through ActiveRecord macros. The Genre model requires only two columns, id and name.

```ruby
  class CreateGenres < ActiveRecord::Migration
    def change
      create_table :genres do |t|
        t.string :name
      end
    end
  end
```
