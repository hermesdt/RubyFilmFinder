class Link < Sequel::Model(:links)
  #one_to_one :film
  many_to_one :film_copy
end
