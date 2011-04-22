class Film < Sequel::Model(:films)
  validates_presence_of :name
  validates_presence_of :date
  validates_presence_of :description
end
