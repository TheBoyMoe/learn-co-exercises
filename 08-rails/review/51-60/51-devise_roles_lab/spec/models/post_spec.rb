require 'rails_helper'

describe Post do
  it 'belongs to a user' do
    expect(Post.new).to respond_to(:user)
  end
end
