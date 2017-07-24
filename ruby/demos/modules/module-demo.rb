require 'pry'

module Dance

  def twirl
    'I\'m twirling'
  end

  def jump
    'I\'m jumping'
  end

  def pirouette
    'I can pirouette'
  end

  def take_a_bow
    'Thank you, it was a pleasure'
  end
end

module MetaDancing

  def metadata
    'Love to dance'
  end
end


class Kid
  include Dance # instance methods
  extend MetaDancing # class methods
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def take_a_bow
    'Cheers'
  end

  def fall
    'Waaaaaaaaa'
  end
end

class Dancer
  include Dance
  extend MetaDancing
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def fall
    'I don\'t fall'
  end
end

binding.pry
