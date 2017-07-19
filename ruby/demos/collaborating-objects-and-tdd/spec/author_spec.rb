
describe Author do
    # dummy instances
    let(:story){Story.new.tap{|s| s.name = 'The Old Man and the Sea'}}
    let(:author){Author.new.tap{|a| a.name = 'Ernest Hemingway'}}

    it 'has a name' do
        expect(author.name).to eq('Ernest Hemingway')
    end

    describe 'has many stories' do
        describe '#stories' do
            it 'has an empty array of stories when initialized' do
                expect(author.stories).to match_array([])
            end

            it 'returns a frozen copy of the stories array' do
                expect(author.stories).to be_frozen
            end
        end
    end

    describe '#add_story' do
        it 'can add a story instance on to the author' do
            author.add_story(story)
            expect(author.stories).to include(story)
        end

        it 'reciprocates and adds the author as the stories author' do
            author.add_story(story)
            expect(story.author).to eq(author)
        end

        it 'only allows instances of story to be pushed on to author' do
            story = 'Old Man of the Sea'
            expect{author.add_story(story)}.to raise_error(AssociationTypeMismatchError)
        end

    end

     describe '#bibliography' do
        it 'returns an array of all the author\'s stories names' do
            s1 = Story.new.tap {|s| s.name = 'Old Man and the Sea'}
            s2 = Story.new.tap {|s| s.name = 'For Whom the Bell Tolls'}
            s3 = Story.new.tap {|s| s.name = 'The Sun also Rises'}

            author.add_story(s1)
            author.add_story(s2)
            author.add_story(s3)

            expect(author.bibliography).to match_array([
                'Old Man and the Sea',
                'For Whom the Bell Tolls',
                'The Sun also Rises'
            ])
        end
    end
    
end