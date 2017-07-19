
describe Category do
    # dummy instances
    let(:category){Category.new.tap{|c| c.name = 'Fiction'}}
    let(:story){Story.new.tap{|s| s.name = "The Old Man of the Sea"}}

    it 'has a category' do
        expect(category.name).to eq('Fiction')
    end

    describe 'has many stories' do
        describe '#stories' do
            it 'has an empty array of stories when initialiazed' do
                expect(category.stories).to match_array([])
            end

            it 'returns a frozen copy of the stories array' do
                expect(category.stories).to be_frozen
            end

        end    
    end

    describe '#add_story' do
        it 'can add a story instance to the category' do
            category.add_story(story)
            expect(category.stories).to include(story)
        end

        it 'reciprocates and adds the category stories category' do
            category.add_story(story)
            expect(story.category).to eq(category)
        end

        it 'only allows instances of story to be pushed on to category' do
            story = 'Old Man of the Sea'
            expect{category.add_story(story)}.to raise_error(AssociationTypeMismatchError)
        end
    end

end