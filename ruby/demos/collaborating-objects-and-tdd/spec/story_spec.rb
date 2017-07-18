
describe Story do
    it 'has a name' do
        story = Story.new
        story.name = 'Hemingway'

        expect(story.name).to eq('Hemingway')
    end

end