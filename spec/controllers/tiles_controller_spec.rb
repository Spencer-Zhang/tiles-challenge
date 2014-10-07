require 'spec_helper'
require 'sidekiq/testing'

Sidekiq::Testing.fake!

describe TilesController do

  before do
    FactoryGirl.create_list(:tile, 64)
    last_tile = Tile.last
    last_tile.name = "ERROR"
    last_tile.save
  end

  describe "#index" do
    it "returns an array of tiles" do
      get :index
      expect(response).to render_template("index")
      tiles = controller.instance_variable_get(:@tiles)
      expect(tiles.size).to eq(64)
    end
  end

  describe "#click" do
    it "generates a new Sidekiq job if no errors occur" do
      tile = Tile.first

      get :click, {name: tile.name}
      job = TileWorker.jobs.last
      expect(job['args'][0]).to eq(tile.name)
      expect(response.body).to eq({job_id: job['jid']}.to_json)
      expect(response.status).to eq(200)
    end

    it "returns status 500 if the tile name is ERROR" do
      get :click, {name: 'ERROR'}
      expect(response.status).to eq(500)
    end
  end

  describe "#most_clicked" do
    it "responds with the tiles with the highest click counts" do
      tile = Tile.first
      tile.click_count = 99
      tile.save
      get :most_clicked

      tiles = controller.instance_variable_get(:@tiles)
      expect(tiles.size).to eq(10)
      expect(tiles[0]["name"]).to eq(tile.name)
      expect(response).to render_template("most_clicked")
    end
  end

  describe "#job_status" do
    it "responds with the status of an existing job" do
      get :click, {name: Tile.first.name}
      job = TileWorker.jobs.last
      get :job_status, {jobID: job['jid']}
      expect(response.body).to eq({status: :queued}.to_json)
    end
  end

end