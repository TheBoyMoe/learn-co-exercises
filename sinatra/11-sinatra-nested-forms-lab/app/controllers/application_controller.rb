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

  get '/' do
    erb :super_hero
  end

  post '/teams' do
    @team = Team.new(params[:team])

    @members = params[:team][:members].collect do |member|
      Hero.new(member)
    end

    erb :team
  end

end
