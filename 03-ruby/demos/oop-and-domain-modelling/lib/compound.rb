require 'pry'
require_relative './atom.rb'

class Compound
  attr_accessor :atoms

  def initialize(*atoms)
    @atoms = []
    atoms.map { |atom| @atoms.push(atom) }
  end

  COMMON_COMPOUNDS = {
    'Water' => 'HHO'
  }

  def elements
    atoms.flatten.collect {|a| a.name[0]}.sort.join.to_s
  end

  def common_name
    COMMON_COMPOUNDS.invert[self.elements]
  end
end

# binding.pry
