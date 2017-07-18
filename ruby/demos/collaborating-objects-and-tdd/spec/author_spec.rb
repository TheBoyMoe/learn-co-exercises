
describe Author do
    it 'has a name' do
        author = Author.new
        author.name = 'Hemingway'

        expect(author.name).to eq('Hemingway')
    end

    describe 'author with stories' do
        describe '#stories' do
            it 'has an empty array of stories when initialized' do
                author = Author.new

                expect(author.stories).to match_array([])
            end
        end
    end

    describe '#add_story' do
        it 'can add a story instance on to the author' do
            author = Author.new
            story = Story.new
            author.add_story(story)

            expect(author.stories).to include(story)
        end

        it 'only allows instances of story to be pushed on to author' do
            author = Author.new
            story = 'Old Man of the Sea'

            expect{author.add_story(story)}.to raise_error(AssociationTypeMismatchError)
        end
    end

end