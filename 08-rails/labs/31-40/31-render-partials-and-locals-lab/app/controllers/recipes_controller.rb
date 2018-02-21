class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :update]
  before_action :get_ingredients, only: [:new, :edit]

  def show
  end

  def index
    @recipes = Recipe.all
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(set_params)
    if @recipe.save
      redirect_to recipe_path @recipe
    else
      render :new
    end
  end

  def edit
  end

  def update
    @recipe.update(set_params)
    if @recipe.valid?
      redirect_to recipe_path @recipe
    else
      render :edit
    end
  end

  private
    def set_params
      params.require(:recipe).permit(:name, ingredient_ids: [])
    end

    def set_recipe
      @recipe = Recipe.find_by(id: params[:id])
    end

    def get_ingredients
      @ingredients = Ingredient.all
    end
end
