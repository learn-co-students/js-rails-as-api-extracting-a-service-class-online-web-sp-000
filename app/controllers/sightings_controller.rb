class SightingsController < ApplicationController
    def show
        sighting = Sighting.find_by(id: params[:id])
        # if sighting
        #     render json: sighting.to_json(:include => {
        #         :bird => {:only =>[:name, :species]}, 
        #         :location => {:only =>[:latitude, :longitude]}
        #         }, :except => [:updated_at])
        # else
        #     render json: {message: "No sighting with id #{params[:id]}"}
        # end
        render json: SightingSerializer.new(sighting).to_serialized_json
    end

    def index
        sightings = Sighting.all
        render json: SightingSerializer.new(sightings).to_serialized_json
    end
end
