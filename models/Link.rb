class Link < Sequel::Model(:links)
  #one_to_one :film
  one_to_one :link_type

  def film
    Film.where("id = ?", self.film_id).first
  end

end
