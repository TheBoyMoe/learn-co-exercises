class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :update]

  def show
  end

  def index
    @recipes = Recipe.all
  end

  def new
    @recipe = Recipe.new
    2.times {@recipe.ingredients.build}
    # @recipe.ingredients.build
  end

  def create
    Recipe.create(recipe_params)
    redirect_to recipes_path
  end


  private
    def set_recipe
      @recipe = Recipe.find(params[:id])
    end

    def recipe_params
      # requires :id so rails updates existing ingredients instead of creating new ones
      params.require(:recipe).permit(:title, ingredients_attributes: [
          :id,
          :name,
          :quantity
        ])
    end
end
