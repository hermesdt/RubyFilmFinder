class CreateFilmsTable < Sequel::Migration

  def up
    create_table(:films) do
      primary_key :id
      String :name, :unique => true
      Text :description
      Date :date
    end
  end

  def down
    drop_table(:films)
  end
end
