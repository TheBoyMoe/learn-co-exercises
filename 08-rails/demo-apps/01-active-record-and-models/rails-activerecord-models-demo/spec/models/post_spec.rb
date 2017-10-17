require 'rails_helper'

describe Post do

  it "can be created" do
    post = Post.create!(title: 'title for my first rails post', description: 'description for my first rails post')

    expect(post).to be_valid
    expect(Post.all.size).to eq(1)
    expect(Post.first).to be_instance_of(Post)
  end

  it "has a summary" do
    post = Post.create!(title: 'just another day at the office', author: 'jim smith', description: 'today I made a million quid, what a day!')

    expect(post.post_summary).to eq("just another day at the office, by jim smith\ndescription - today I made a million quid, what a day!")
  end
end
