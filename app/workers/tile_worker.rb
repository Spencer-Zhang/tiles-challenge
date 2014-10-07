class TileWorker
  include Sidekiq::Worker
  include Sidekiq::Status::Worker

  sidekiq_options retry: false

  def perform(name, timestamp)
    tile = Tile.find_by(name: name)
    tile.click_count += 1
    tile.save
  end
end