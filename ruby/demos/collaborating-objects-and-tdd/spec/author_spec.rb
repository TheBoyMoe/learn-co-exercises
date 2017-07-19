
describe Author do
    let(:author){Author.new}

    it 'has a name' do
        # author = Author.new
        author.name = 'Hemingway'
        expect(author.name).to eq('Hemingway')
    end

    describe 'has many stories' do
        describe '#stories' do
            it 'has an empty array of stories when initialized' do
                # author = Author.new
                expect(author.stories).to match_array([])
            end

            it 'returns a frozen copy of the stories array' do
                # author = Author.new
                expect(author.stories).to be_frozen
            end
        end
    end

    describe '#add_story' do
        it 'can add a story instance on to the author' do
            # author = Author.new
            story = Story.new
            author.add_story(story)
            expect(author.stories).to include(story)
        end

        it 'only allows instances of story to be pushed on to author' do
            # author = Author.new
            story = 'Old Man of the Sea'
            expect{author.add_story(story)}.to raise_error(AssociationTypeMismatchError)
        end
    end

     describe '#bibliography' do
        it 'returns an array of all the author\'s stories names' do
            # author = Author.new
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