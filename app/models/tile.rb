class Tile
  include Mongoid::Document

  field :name,          type: String
  field :click_count,   type: Integer, default: 0

end
