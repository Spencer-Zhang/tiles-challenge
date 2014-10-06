class TilesController < ApplicationController
  def index
    @tiles = Tile.all.as_json
    p @tiles
  end

  def update
    raise "Error" if params["name"] == "13"

    tile = Tile.find_by(name: params["name"])
    tile.click_count += 1
    tile.save

    render nothing: true
  end

  def most_clicked
    tiles = Tile.all.sort(click_count: -1).limit(10)
    render json: tiles.as_json
  end
end
