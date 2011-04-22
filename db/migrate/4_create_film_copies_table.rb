class CreateFilmCopiesTable < Sequel::Migration
  def up
    create_table :film_copies do
      primary_key :id
      foreign_key :film_id, :films
      foreign_key :server_id, :servers
      foreign_key :film_copy_type_id, :film_copy_types
    end
  end

  def down
    drop_table :film_copies
  end
end
