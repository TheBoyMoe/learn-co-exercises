module ApplicationHelper
  # place all your application wide helpers in this file
  # e.g #current_user - used in mosts views in the app

  # title helper
  # on author page, title is the author name
  # on post page, title is the post title
  def title(text)
    # using rails #content_for helper
    content_for :title, text
  end

end
