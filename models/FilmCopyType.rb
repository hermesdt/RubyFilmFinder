class FilmCopyType < Sequel::Model(:film_copy_types)
  many_to_one :film_copies
end
