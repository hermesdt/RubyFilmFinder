class CreateLinksTable < Sequel::Migration
  def up
    create_table :links do
      primary_key :id
      String :url, :unique => true
      foreign_key :film_copy_id, :film_copies
    end
  end
  
  def down
    drop_table :links
  end
end
