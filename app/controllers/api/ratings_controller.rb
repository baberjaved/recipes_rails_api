class Api::RatingsController < Api::BaseController
  # jitera-anchor-dont-touch: before_action_filter
  before_action :doorkeeper_authorize!, only: %w[index show update destroy search]
  before_action :current_user_authenticate, only: %w[index show update destroy search]
  before_action :find_recipe
  before_action :find_rating, only: [:show, :update, :destroy]

  # jitera-anchor-dont-touch: actions

  def index
    @ratings = @recipe.ratings.includes(:user)
  end

  def create
    @rating = Rating.new(rating_params)
    @rating.recipe_id = @recipe.id
    @rating.save
  end

  def show; end

  def destroy
    @rating.destroy
  end

  def update
    @rating.update(rating_params)
  end
  
  private

  def find_recipe
    @recipe = Recipe.find_by(id: params[:recipe_id])
  end

  def find_rating
    @rating = @recipe.ratings.find_by(id: params[:id])
  end

  def rating_params
    params.permit(:score, :user_id)
  end
end
