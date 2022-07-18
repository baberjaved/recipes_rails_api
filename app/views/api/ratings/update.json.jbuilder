if @error_message.blank?
  json.rating do
    json.id @rating.id
    json.created_at @rating.created_at
    json.updated_at @rating.updated_at
    json.score @rating.score

    json.recipe do
      json.id @rating.recipe.id
      json.title @rating.recipe.title
    end

    json.user do
      json.id @rating.user.id
      json.email @rating.user.email
    end
  end
else
  json.error_message @error_message
end
