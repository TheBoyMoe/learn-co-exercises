module AuthorsHelper

	def display_author(post)
		(post.author.nil?)? link_to("Add Author", edit_post_path(post)) :
				link_to(post.author.name, author_path(post.author))
	end
end
