class FetchRecipes
  include Interactor

  SEARCH_COLUMNS = [
    'title'
  ]

  def call
    initialize_recipes
    apply_filters
  end

  protected

  def params
    context.params.presence || {}
  end

  def initialize_recipes
    context.recipes = context.scope || Recipe.includes(:ingredients).all
  end

  def apply_filters
    apply_full_text_search
    apply_time_range
    apply_difficulty
  end

  def apply_full_text_search
    return if params[:query].blank?

    context.recipes = context.recipes.full_text_search(params[:query], SEARCH_COLUMNS)
  end

  def apply_time_range
    return if params[:time_range].blank?

    context.recipes = context.recipes.filter_time_range(params[:time_range])
  end

  def apply_difficulty
    return if params[:difficulty].blank?

    context.recipes = context.recipes.filter_difficulty(params[:difficulty])
  end
end
