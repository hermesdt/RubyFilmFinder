class Film < Sequel::Model(:films)
  many_to_many :categories
  one_to_many :film_copies
end
