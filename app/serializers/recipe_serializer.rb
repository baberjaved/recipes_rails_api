class RecipeSerializer < BaseSerializer
  attributes :id, :created_at, :updated_at, :title, :descriptions, :time, :difficulty, :category_id, :user_id, :average_rating

  has_many :ingredients
  has_many :ratings
end
