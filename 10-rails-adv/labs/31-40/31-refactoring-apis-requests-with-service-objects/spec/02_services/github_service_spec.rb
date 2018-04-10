require_relative '../spec_helper'

describe 'GithubService' do
  describe "initialization" do
    it "can be initialized without an `access_hash`" do
      service = GithubService.new
      expect(service.access_token).to eq(nil)
    end

    it "can be initialized with an `access_hash`" do
      service = GithubService.new({"access_token" => "1"})
      expect(service.access_token).to eq('1')
    end
  end

  describe '#authenticate!' do
    before :each do
      @service = GithubService.new
      @service.authenticate!(ENV["GITHUB_CLIENT"], ENV["GITHUB_SECRET"], "20")
    end

    it "sends the correct POST request" do
      expect(WebMock).to have_requested(:post, "https://github.com/login/oauth/access_token").
        with(:body => {"client_id"=> ENV["GITHUB_CLIENT"], "client_secret"=> ENV["GITHUB_SECRET"], "code"=>"20"},
        :headers => {'Accept'=>'application/json'})
    end

    it "sets @access_token for a GithubService" do
      expect(@service.access_token).to eq('1')
    end
  end

  describe '#get_username' do
    before :each do
      @service = GithubService.new({"access_token" => "1"})
      @username = @service.get_username
    end

    it "sends the correct GET request" do
      expect(WebMock).to have_requested(:get, "https://api.github.com/user").
        with(:headers => {'Authorization'=>'token 1'})
    end

    it "returns the username" do
      expect(@username).to eq("your_username")
    end
  end

  describe '#get_repos' do
    before :each do
      @service = GithubService.new({"access_token" => "1"})
      @repos_array = @service.get_repos
    end

    it "sends the correct GET request" do
      expect(WebMock).to have_requested(:get, "https://api.github.com/user/repos").
        with(:headers => {'Authorization'=>'token 1'})
    end

    it "returns an array of GithubRepo objects" do
      expect(@repos_array.length).to eq(3)
      expect(@repos_array.first.class).to eq(GithubRepo)
      expect(@repos_array.first.name).to eq("Repo 1")
    end
  end

  describe '#create_repo' do
    it "sends the correct POST request" do
      stubbed = stub_request(:post, "https://api.github.com/user/repos").
        with(body: {"name":"a-new-repo"}.to_json, headers: {'Authorization'=>'token 1'})

      service = GithubService.new({"access_token" => "1"})
      service.create_repo("a-new-repo")

      expect(stubbed).to have_been_requested
    end
  end
end
