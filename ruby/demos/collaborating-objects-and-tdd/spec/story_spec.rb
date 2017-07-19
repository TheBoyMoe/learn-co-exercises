
describe Story do
    let(:story){Story.new.tap{|s| s.name = 'The Old Man and the Sea'}}
    let(:author){Author.new.tap{|a| a.name = 'Ernest Hemingway'}}
    let(:category){Category.new.tap{|c| c.name = 'Fiction'}}

    it 'has a name' do
        expect(story.name).to eq('The Old Man and the Sea')
    end

    describe 'with an author' do
        describe '#author' do 
            it 'can set an author' do
                story.author =  author
                expect(story.author).to eq(author)
            end

            it 'throws an error if assigned anything other than an author instance' do
                expect{story.author = 'Ernest Hemingway'}.to raise_error(AssociationTypeMismatchError)
            end

            it 'reciprocates and adds the story to the author\'s stories collection' do
                story.author = author
                expect(author.stories).to include(story)
            end
        end
    end

    describe 'with a category' do
        describe '#category' do
            it 'can set a category' do
                story.category = category
                expect(story.category).to eq(category)
            end

            it 'throws an error if assigned anything other than a category instance' do
                expect{story.category = 'Fiction'}.to raise_error(AssociationTypeMismatchError  )
            end

            it 'reciprocates and adds the story to the category\'s stories callection' do
                story.category = category
                expect(category.stories).to include(story)
            end
        end
    end

end