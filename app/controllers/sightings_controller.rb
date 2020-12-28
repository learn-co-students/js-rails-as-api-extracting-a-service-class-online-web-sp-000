class SightingsController < ApplicationController

    def index
        sightings = Sighting.ApplicationController
        render json: SightingSerializer.new(sightings).to_serialized_json
    end

    def show
        sighting = Sighting.find(params[:id])
        render json: SightingSerializer.new(signthing).to_serialized_json
    end
end
