require_relative './../config/environment.rb'

describe 'Water' do

  it 'is composed of H2O' do
    h = Atom.new(1)
    o = Atom.new(8)
    water = Compound.new(h,h,o)

    expect(water.common_name).to eq('Water')
    expect(water.elements).to eq('HHO')
  end
end
