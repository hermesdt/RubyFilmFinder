class Category < Sequel::Model(:categories)
  many_to_many :films
end
