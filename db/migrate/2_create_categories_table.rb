class CreateCategoriesTable < Sequel::Migration
  def up
    create_table :categories do
      primary_key :id
      String :name
    end
  end

  def down
    drop_table :categories
  end
end
