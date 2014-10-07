require 'spec_helper'

def get_tile_names
  page.all('.tile').map{|e| e.native.text}
end

def click_all_tiles
  page.all('.tile').each{ |e| e.click }
end

describe "Index page" do
  before do
    FactoryGirl.create_list(:tile, 64)
    last_tile = Tile.last
    last_tile.name = "ERROR"
    last_tile.save

    visit '/'
  end

  it "displays an 8x8 grid of tiles with different strings" do
    page.should have_css(".tile", count: 64)
  end

  it "should have a unique string in every tile" do
    strings = get_tile_names
    expect(strings.uniq.size).to eq(64)
  end

  it "should randomize the tiles each time the page is loaded" do
    strings = get_tile_names
    visit '/'
    strings2 = get_tile_names

    expect(strings).to_not eq(strings2)
  end

  it "should hide a tile that has been clicked on" do
    tile = page.first('.tile')
    tile.click
    opacity = page.evaluate_script("$('.tile').eq(0).css('opacity')")
    expect(opacity).to eq('0')
  end

  it "should show a list of tiles that have been clicked most often when every tile has been clicked" do
    tile = Tile.first
    tile.click_count = 99
    tile.save

    click_all_tiles

    page.should have_css(".chart")
    page.should have_css(".title", count: 11)
    expect(page.all('.title')[1].native.text).to eq(tile.name)
  end

end