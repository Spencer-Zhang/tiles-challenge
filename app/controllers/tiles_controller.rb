class TilesController < ApplicationController
  def index
    @tiles = Tile.all.as_json.shuffle!
  end

  def update
    raise "Error" if params["name"] == "ERROR"

    tile = Tile.find_by(name: params["name"])
    tile.click_count += 1
    tile.save

    render nothing: true
  end

  def most_clicked
    @tiles = Tile.all.sort(click_count: -1).limit(10)
    respond_to do |format|
      format.html { render layout: true }
      format.text { render layout: false }
    end
  end
end
