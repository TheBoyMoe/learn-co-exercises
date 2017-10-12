require 'pry'

module Dance

  module InstanceMethods
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

  module ClassMethods
    def metadata
      'Love to dance'
    end
  end

end

def metadata
  'Love to dance'
end

class Kid
  include Dance::InstanceMethods # instance methods
  extend Dance::ClassMethods # class methods
  attr_accessor :name

  def initialize(name)
    @name = name
  end

end

class Dancer
  include Dance::InstanceMethods
  extend Dance::ClassMethods
  attr_accessor :name

  def initialize(name)
    @name = name
  end

end

binding.pry
