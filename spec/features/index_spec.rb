require 'spec_helper'

def get_page_content
  (1..64).to_a.map {|i| find(".tile:nth-of-type(#{i})").native.text}
end

describe "Index page" do
  before do
    Capybara.current_driver = :selenium
    FactoryGirl.create_list(:tile, 64)
    last_tile = Tile.last
    last_tile.name = "ERROR"
    last_tile.save

    visit '/'
  end

  after do
    Capybara.use_default_driver
  end

  it "displays an 8x8 grid of tiles with different strings" do
    page.should have_css(".tile", count: 64)
  end

  it "should have a unique string in every tile" do
    contents = get_page_content

    expect(contents.uniq.size).to eq(64)
  end

  it "should randomize the tiles each time the page is loaded" do
    contents = get_page_content
    visit '/'
    contents2 = get_page_content

    expect(contents).to_not eq(contents2)
  end

end