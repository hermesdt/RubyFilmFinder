class CreateFilmCategoriesTable < Sequel::Migration

  def up
    create_table :film_categories do
      primary_key :id
      foreign_key :film_id, :films
      foreign_key :category_id, :categories
      unique [:film_id, :category_id]
    end
  end

  def down
    drop_table :film_categories
  end
end
