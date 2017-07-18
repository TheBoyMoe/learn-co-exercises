
describe Author do
    it 'has a name' do
        author = Author.new
        author.name = 'Hemingway'

        expect(author.name).to eq('Hemingway')
    end

end