class AuthorSerializer < ActiveModel::Serializer
  # renders author id & name, with an array of posts with all post attributes
  attributes :id, :name
  has_many :posts
end
