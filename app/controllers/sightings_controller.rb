class SightingsController < ApplicationController

    def index
        sightings = Sighting.all
        render json: SightingSeralizer.new(sightings).to_serialized_json
    end
    def show
        sighting = Sighting.find_by(id: params[:id])
        render json: SightingSeralizer.new(sighting).to_serialized_json
    end
end
