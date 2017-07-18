
describe Category do
    it 'has a category' do
        category = Category.new
        category.name = "Fiction"

        expect(category.name).to eq('Fiction')
    end
end