# Useful Model Methods

```ruby
# would be better as a helper, model should not deal with presentation logic, only business logic
# app/models/post.rb 
def last_updated
  updated_at.strftime("Last updated %A, %b %e, at %l:%M %p")
end
```

```ruby
# app/helpers/posts_helper.rb
def last_updated(post)
  post.updated_at.strftime("Last updated %A, %b %e, at %l:%M %p")
end
```

```ruby
def self.search(query)
	if query.present?
		where('NAME like ?', "%#{query}%")
	else
		self.all
	end
end
```

```ruby
def oldest_student
	students.where("birthday is not null").order("birthday asc").first
end
```


Custom attribute accessor methods, add the attribute to the #strong_params

```ruby
	# app/model/song.rb - add 'virtual' attribute
	def artist_name
    artist.name unless artist == nil
  end

  # assign an artist to the song
  def artist_name=(name)
    unless !name || name.empty?
      artist = Artist.find_or_create_by(name: name)
      self.artist = artist
      save
    end
  end
  
  #app/controllers/songs_controller.rb
  def song_params
		params.require(:song).permit(:title, :artist_name)
	end 
```