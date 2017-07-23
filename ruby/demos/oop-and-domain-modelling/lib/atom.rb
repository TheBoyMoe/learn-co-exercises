require 'pry'

class Atom
  attr_accessor :protons
  TABLE = {
    1 => 'Hydrogen',
    2 => 'Helium',
    3 => 'Lithium',
    4 => 'Berylium',
    5 => 'Boron',
    6 => 'Carbon',
    7 => 'Nitrogen',
    8 => 'Oxygen'
  }

  def initialize(protons)
    @protons = protons
  end

  def name
    TABLE[self.protons]
  end
end


# binding.pry
