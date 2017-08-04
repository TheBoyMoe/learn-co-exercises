class RubyNews::InvalidType < StandardError; end

class RubyNews::NewsLetter
  attr_accessor :issue_number, :issue_date

  def initialize
    @articles = []
  end

  # return an immutable copy of articles
  def articles
    @articles.dup.freeze
  end

  def add_article(article)
    if !article.is_a?(RubyNews::Article)
      raise RubyNews::InvalidType, "Must be an Article"
    else
      @articles << article
    end
  end

end
