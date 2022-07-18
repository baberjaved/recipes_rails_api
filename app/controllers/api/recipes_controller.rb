class Api::RecipesController < Api::BaseController
  # jitera-anchor-dont-touch: before_action_filter
  before_action :doorkeeper_authorize!, only: %w[index show update destroy]
  before_action :current_user_authenticate, only: %w[index show update destroy]
  before_action :set_recipe, only: %i[show update destroy]

  # jitera-anchor-dont-touch: actions
  def index
    result = FetchRecipes.call(scope: Recipe.includes(:ingredients).all, params: params)
    @recipes = result.recipes
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @error_object = @recipe.errors.messages unless @recipe.save
  end

  def show
    @error_message = true if @recipe.blank?
  end

  def update
    @error_object = @recipe.errors.messages unless @recipe.update(recipe_params)
  end

  def destroy
    @error_message = true unless @recipe&.destroy
  end

  def weight_converter
    @converter = Ingredient.weight_converter(weight_converter_params)
  end

  private

  def set_recipe
    @recipe = Recipe.find_by(id: params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:title, :descriptions, :time, :difficulty, :user_id, :category_id, ingredients: [])
  end

  def weight_converter_params
    params.permit(:unit_from, :unit_to, :amount)
  end
end
