class TilesController < ApplicationController
  def index
    @tiles = Tile.all.as_json.shuffle!
  end

  def update
    job_id = TileWorker.perform_async(params["name"], Time.now)
    render json: {job_id: job_id}
  end

  def most_clicked
    @tiles = Tile.all.sort(click_count: -1).limit(10)
    respond_to do |format|
      format.html { render layout: true }
      format.text { render layout: false }
    end
  end

  def job_status
    job_id = params["jobID"]
    render json: {status: Sidekiq::Status::status(job_id)}
  end
end
