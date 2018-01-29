require 'rails_helper'

RSpec.describe Ability do
  users = Hash[['alice', 'beth', 'eve'].map do |name|
    user = User.create name: name
    [name.to_sym, user]
  end]
  abilities = Hash[users.map do |name, user|
    [name, Ability.new(user)]
  end]
  private_notes = Hash[users.map do |name, user|
    note = Note.create content: "#{name}'s secret note.", user: user
    [name, note]
  end]
  alice_to_beth = Note.create(
    user: users[:alice],
    content: "This is a secret for Beth's eyes only!",
    readers: [users[:beth]]
  )
  beth_to_eve = Note.create(
    user: users[:beth],
    content: "I'm sorry you and Alice are still fighting.",
    readers: [users[:eve]]
  )
  # Reload to pick up associations.
  users.each { |name, user| user.reload }

  describe 'users' do
    it "can :read their own posts" do
      users.each do |name, user|
        assert abilities[name].can? :read, private_notes[name]
      end
    end
    
    it "can't :read posts they're not viewers of" do
      assert abilities[:eve].cannot? :read, alice_to_beth
    end

    it "can :read posts they're viewers of" do
      assert abilities[:beth].can? :read, alice_to_beth
      assert abilities[:eve].can? :read, beth_to_eve
    end

    it "can :update their own notes" do
      users.each do |name, user|
        assert abilities[name].can? :update, private_notes[name]
      end
    end

    it "can't :update any other user's notes" do
      users.each do |name, user|
        users.reject {|n| n == name}.each do |other_name, other_user|
          assert abilities[other_name].cannot? :update, private_notes[name]
        end
      end
    end
  end
end
