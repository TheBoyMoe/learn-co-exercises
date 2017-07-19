
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


    describe 'has many authors through stories' do
        it 'returns the callection of unique author instances based on the stories' do
            king = Author.new.tap{|a| a.name = 'Stephen King'}
            hemingway = Author.new.tap{|a| a.name = 'Ernest Hemingway'}

            s1 = Story.new.tap {|s| s.name = 'Old Man and the Sea'; s.author = hemingway}
            s2 = Story.new.tap {|s| s.name = 'For Whom the Bell Tolls'; s.author = hemingway}
            s3 = Story.new.tap {|s| s.name = 'The Shining'; s.author = king}

            s1.category = category
            s2.category = category
            s3.category = category

            expect(category.authors).to match_array([king, hemingway])
        end
    end

end