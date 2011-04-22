class CreateLinkTypesTable < Sequel::Migration
  def up
    create_table :link_types do
      primary_key :id
      String :name, :unique => true
    end
  end

  def down
    drop_table :link_types
  end
end
