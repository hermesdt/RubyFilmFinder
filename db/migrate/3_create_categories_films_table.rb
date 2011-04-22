class CreateCategoriesFilmsTable < Sequel::Migration

  def up
    create_table :categories_films do
      primary_key :id
      foreign_key :film_id, :films
      foreign_key :category_id, :categories
      unique [:film_id, :category_id]
    end
  end

  def down
    drop_table :categories_films
  end
end
