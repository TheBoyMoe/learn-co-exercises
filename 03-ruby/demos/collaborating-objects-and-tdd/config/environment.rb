require 'pry'

require_relative '../lib/author.rb'
require_relative '../lib/category.rb'
require_relative '../lib/story.rb'

# custom type error
class AssociationTypeMismatchError < TypeError; end