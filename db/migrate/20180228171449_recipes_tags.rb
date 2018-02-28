class RecipesTags < ActiveRecord::Migration[5.1]
  def change
    create_table(:recipes_tags) do |t|
      t.column(:recipe_id, :int)
      t.column(:tag_id, :int)
    end
  end
end
