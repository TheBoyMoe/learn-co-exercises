require 'rails_helper'

RSpec.describe NotesController, type: :controller do
  fixtures :users
  describe 'post create' do
    it "can't create a note if you're not logged in" do
      post :create, note: {content: 'hush', visible_to: ''}
      assert_redirected_to '/'
    end
    it "can create a note if you're logged in" do
      alice = users(:alice)
      content = 'secret message'
      session[:user_id] = alice.id
      post :create, note: {content: content, visible_to: ''}
      assert_redirected_to '/'
      note = Note.last
      assert note.content == content
      assert note.readers == [alice]
      assert note.user = alice
    end
  end

  describe 'post update' do
    it "can update your own notes" do
      alice, beth = users(:alice), users(:beth)
      session[:user_id] = beth.id
      
      content = 'oh so secret'
      post :create, note: {content: content, visible_to: ''}
      note_id = Note.last.id
      assert Note.find(note_id).content == content

      new_content = 'a different secret'
      post :update, id: note_id, note: {content: new_content, visible_to: 'alice'}
      assert_redirected_to '/'
      note = Note.find(note_id)
      assert note.content == new_content
      assert note.readers == [alice, beth]
    end
  end
end
