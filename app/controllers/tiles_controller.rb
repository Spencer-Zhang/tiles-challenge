class TilesController < ApplicationController
  def index
    @tiles = []
    Tile.each do |tile|
      @tiles << tile
    end
  end

  def update
    raise "Error" if params["name"] == "13"

    tile = Tile.find_by(name: params["name"])
    tile.click_count += 1
    tile.save

    render json: ['Success']
  end
end
