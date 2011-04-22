class CreateFilmCopyTypesTable < Sequel::Migration
  def up
    create_table :film_copy_types do
      primary_key :id
      String :name
    end
  end

  def down
    drop_table :film_copy_types
  end
end
