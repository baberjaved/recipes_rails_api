json.ratings @ratings do |rating|
  json.id rating.id
  json.created_at rating.created_at
  json.updated_at rating.updated_at
  json.score rating.score

  json.recipe do
    json.title rating.recipe.title
  end

  json.user do
    json.email rating.user.email
  end
end
