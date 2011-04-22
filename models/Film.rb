class Film < Sequel::Model(:films)
  many_to_many :categories
  one_to_one :link
end
