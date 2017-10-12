### collaborating objects

model:

authors
    has_many stories
    has_many categories, through stories

stories
    belongs to an author
    belongs to a category

categories
    has_many stories
    has_many authors, through stories

example

hemingway = Author.new
hemingway.stories #=> [#<Story>, #<Story>]

hemingway.categories #=> [#<Category 'Fiction'>, #<Category 'Non Fiction'>]