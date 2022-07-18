class Api::CategoriesController < Api::BaseController
  # jitera-anchor-dont-touch: before_action_filter
  before_action :set_ingredient, only: %i[show update destroy]

  # jitera-anchor-dont-touch: actions
   def index
    @categories = Category.includes(:recipes, :ingredients).all
  end

  def create
    @category = Category.new(category_params)
    @error_object = @category.errors.messages unless @category.save
  end

  def show
    @error_message = true if @category.blank?
  end

  def update
    @error_object = @category.errors.messages unless @category.update(category_params)
  end

  def destroy
    @error_message = true unless @category&.destroy
  end

  private

  def set_category
    @category = Category.find_by(id: params[:id])
  end

  def category_params
    params.require(:category).permit(:description)
  end
end
