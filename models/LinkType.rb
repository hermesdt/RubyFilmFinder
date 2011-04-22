class LinkType < Sequel::Model(:link_types)
  many_to_one :links
end
