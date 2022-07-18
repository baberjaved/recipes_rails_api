class AddColumnInRecipes < ActiveRecord::Migration[7.0]
  def change
    add_column :recipes, :time_in_seconds, :integer
    add_column :recipes, :average_rating, :float
  end
end
