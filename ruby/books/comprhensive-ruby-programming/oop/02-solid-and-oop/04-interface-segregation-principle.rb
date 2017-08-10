require 'forwardable'

class Blog
  def edit_post
    puts "Post edited"
  end

  def delete_post
    puts "Post removed"
  end

  def create_post
    puts "Post created"
  end
end

# Moderators should only be able to edit a post, by inheriting from the Blog class, moderators can edit, delete and create posts
class Moderator < Blog
end

moderator = Moderator.new
moderator.edit_post
moderator.delete_post
moderator.create_post

=begin
  Ruby offers the 'Forwardable' module, which we can use to limit the scope of what the Moderator class has access to.

  The Moderator class no longer inherits from the Blog class, instead we use 'Forwardable's #def_delegators method to list what methods the Moderator class should have access to.

  When we initialize the moderator, it needs to take a blog instance as an argument.

  Using this technique, moderators can edit posts but not create or delete.
=end

class Moderator
  extend Forwardable
  def_delegators:@blog, :edit_post

  def initialize(blog)
    @blog = blog
  end
end

moderator = Moderator.new(Blog.new)
moderator.edit_post
moderator.delete_post
