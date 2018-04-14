class PostSerializer < ActiveModel::Serializer
  # render post id, title & description with the author name
  attributes :id, :title, :description

  # by default rails uses the AuthorSerializer
  # belongs_to :author

  # use a custom serializer for author to control what author info is returned
  belongs_to :author, serializer: PostAuthorSerializer # returns only name
end
