class SightingsController < ApplicationController
    def show
        sighting = Sighting.find(params[:id])
        render json: SightingSerializer.new(sighting).to_serialized_json
    end

    def index 
        sightings = Sighting.all 
        render json: SightingSerializer.new(sightings).to_serialized_json
    end 
end
