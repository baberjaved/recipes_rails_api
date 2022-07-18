class Rating < ApplicationRecord
  include ConstantValidatable

  # jitera-anchor-dont-touch: relations

  belongs_to :user

  belongs_to :recipe

  # jitera-anchor-dont-touch: enum

  # jitera-anchor-dont-touch: file

  # jitera-anchor-dont-touch: validation

  # jitera-anchor-dont-touch: reset_password

  validates :score, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }

  after_save :compute_recipe_average_rating

  class << self
  end

  def compute_recipe_average_rating
    average = (recipe.ratings.sum(&:score) / recipe.ratings.count).to_f
    recipe.update(average_rating: average)
  end
end
