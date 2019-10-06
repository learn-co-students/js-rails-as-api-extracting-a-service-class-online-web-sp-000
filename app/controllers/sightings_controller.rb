class SightingsController < ApplicationController
  def index
    @sightings = Sighting.all
    render json: @sightings.to_serialized_json
  end

  def show
    @sighting = Sighting.find(params[:id])
    render json: @sighting.to_serialized_json
  end
end
