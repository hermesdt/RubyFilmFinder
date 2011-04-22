class CreateServersTable < Sequel::Migration
  def up
    create_table :servers do
      primary_key :id
      String :name
    end
  end

  def down
    drop_table :servers
  end
end
