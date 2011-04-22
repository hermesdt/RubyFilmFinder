class FilmCopy < Sequel::Model(:film_copies)
  many_to_one :films
  one_to_many :links
  many_to_one :servers
  many_to_one :film_copy_types
end
