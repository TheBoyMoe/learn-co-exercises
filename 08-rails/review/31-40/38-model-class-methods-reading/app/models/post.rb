class Post < ActiveRecord::Base
  belongs_to :author

  validate :is_title_case
  before_validation :make_title_case

  def self.by_author(id)
    author = Author.find(id)
    unless author == nil
      author.posts
    end
  end

  def self.from_today

  end

  def self.old_news

  end

  private

  def is_title_case
    if title.split.any?{|w|w[0].upcase != w[0]}
      errors.add(:title, "Title must be in title case")
    end
  end

  def make_title_case
    self.title = self.title.titlecase
  end
end
