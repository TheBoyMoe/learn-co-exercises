module PostsHelper
  # helpers are organised by controller, but CAN be used with any view
  # application helpers are application wide
  # format updated_at, e.g. Saturday, Nov 25, at 11:49 AM
  def last_updated(post)
    post.updated_at.strftime("Last updated: %A, %b %e, at %l:%M %p")
  end

end
