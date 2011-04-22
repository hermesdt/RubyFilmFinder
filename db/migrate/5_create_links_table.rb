class CreateLinksTable < Sequel::Migration
  def up
    create_table :links do
      primary_key :id
      String :url, :unique => true
      foreign_key :film_id, :films
      foreign_key :type_id, :types
    end
  end
  
  def down
    drop_table :links
  end
end
