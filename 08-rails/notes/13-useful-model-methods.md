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
