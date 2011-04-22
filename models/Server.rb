class Server < Sequel::Model(:servers)
  one_to_many :film_copies
end
