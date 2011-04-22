class CategoryFilm < Sequel::Model(:categories_films)
  one_to_one :film
  one_to_one :category
end
