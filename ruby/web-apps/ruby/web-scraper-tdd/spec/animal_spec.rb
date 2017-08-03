
describe Animal do

  describe 'setup of Animal properties'do
    let(:animal){Animal.new}

    it 'has a name property assigned on initialization' do
        animal.name = 'Name'
        expect(animal.name).to eq('Name')
    end
    it 'has a kingdom property assigned on initialization' do
        animal.kingdom = 'Kingdom'
        expect(animal.kingdom).to eq('Kingdom')
    end
    it 'has a phylum property assigned on initialization' do
      animal.phylum = 'Phylum'
      expect(animal.phylum).to eq('Phylum')
    end
    it 'has a klass property assigned on initialization' do
      animal.klass = 'Klass'
      expect(animal.klass).to eq('Klass')
    end
    it 'has a order property assigned on initialization' do
      animal.order = 'Order'
      expect(animal.order).to eq('Order')
    end
    it 'has a family property assigned on initialization' do
      animal.family = 'Family'
      expect(animal.family).to eq('Family')
    end
    it 'has a genus property assigned on initialization' do
      animal.genus = 'Genus'
      expect(animal.genus).to eq('Genus')
    end
    it 'has a species property assigned on initialization' do
      animal.species = 'Species'
      expect(animal.species).to eq('Species')
    end

  end

  describe '#new_from_wikipedia' do
    it 'instantiates an animal based on a wikipedia url' do
      hippo = Animal.new_from_wikipedia('https://en.wikipedia.org/wiki/Hippopotamus')

      expect(hippo).to be_an_instance_of(Animal)
      expect(hippo.name).to eq('Hippopotamus')
      expect(hippo.kingdom).to eq('Animalia')
      expect(hippo.phylum).to eq('Chordata')
      expect(hippo.klass).to eq('Mammalia')
      expect(hippo.order).to eq('Artiodactyla')
      expect(hippo.family).to eq('Hippopotamidae')
      expect(hippo.genus).to eq('Hippopotamus')
      # expect(hippo.species).to eq('H.&nbsp;amphibius')
    end
  end

end
