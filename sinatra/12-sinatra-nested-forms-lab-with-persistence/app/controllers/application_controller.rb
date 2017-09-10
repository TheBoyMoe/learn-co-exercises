=begin
{
  params => {
    team => {
      name => '',
      motto => '',
      members => [
        {
          name => '',
          power => '',
          bio => ''
        },
        {
          name => '',
          power => '',
          bio => ''
        },
        {
          name => '',
          power => '',
          bio => ''
        }
      ]
    }
  }
}


=end
require 'sinatra/base'

class App < Sinatra::Base

  set :views, Proc.new { File.join(root, "../views/") }

  # root -> forward to /teams
  get '/' do
    redirect :'/teams'
  end

  # teams#index action -> show all items
  get '/teams' do
    @teams = Team.all
    erb :index
  end

  # teams#new action -> allow user to create a new item
  get '/teams/new' do
    erb :new
  end

  # teams#show action -> show item
  get '/teams/:id' do
    @team = Team.find(params[:id])

    erb :show
  end

  # POST teams#create action -> add a new team with members
  post '/teams' do
    team = Team.create(name: params[:team][:name], motto: params[:team][:motto])

    params[:team][:members].collect do |member|
      hero = Hero.new(member)
      hero.team = team
      hero.save
    end

    redirect :"/teams/#{team.id}"
  end

  # teams#edit action -> allow user to edit item


  # teams#update Action -> commit changes


  # teams#destroy action -> delete item


end
