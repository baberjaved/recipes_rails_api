class Api::IngredientsController < Api::BaseController
  # jitera-anchor-dont-touch: before_action_filter
  before_action :set_ingredient, only: %i[show update destroy]

  # jitera-anchor-dont-touch: actions
  def index
    @ingredients = Ingredient.all
  end

  def create
    @ingredient = Ingredient.new(ingredient_params)
    @error_object = @ingredient.errors.messages unless @ingredient.save
  end

  def show
    @error_message = true if @ingredient.blank?
  end

  def update
    @error_object = @ingredient.errors.messages unless @ingredient.update(ingredient_params)
  end

  def destroy
    @error_message = true unless @ingredient&.destroy
  end

  private

  def set_ingredient
    @ingredient = Ingredient.find_by(id: params[:id])
  end

  def ingredient_params
    params.require(:ingredient).permit(:unit, :amount, :recipe_id)
  end
end
