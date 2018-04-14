class GamesController < ApplicationController

  def index
    games = Game.all
    render json: games, status: 200
  end

  def create
    game = Game.create(game_params)
    render json: game, status: 201
  end

  def show
    game = Game.find(params[:id])
    render json: game, status: 200
  end

  def update
    game = Game.find(params[:id])
    if game.update(game_params)
      render json: game, status: 200
    end
  end

  private
    def game_params
      params.permit(state: [])
    end

end
