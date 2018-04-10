require_relative '../spec_helper'

describe 'GithubRepo' do
  describe "initialization with hash" do
    it "sets key 'name' to @name" do
      repo = GithubRepo.new({"name" => 'a-repo', "html_url" => 'http://path.com'})
      expect(repo.name).to eq('a-repo')
    end

    it "sets key 'html_url' to @url" do
      repo = GithubRepo.new({"name" => 'a-repo', "html_url" => 'http://path.com'})
      expect(repo.url).to eq('http://path.com')
    end
  end
end