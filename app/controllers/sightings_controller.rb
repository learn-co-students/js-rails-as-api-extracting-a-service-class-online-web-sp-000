class SightingsController < ApplicationController
    def index
      sightings = Sighting.all
      #call to_serialized_json to get our data customized and ready as a JSOn string
      #replaced render statements with our service class:
      render json: SightingSerializer.new(sightings).to_serialized_json
    end
   
    def show
      sighting = Sighting.find_by(id: params[:id])
            #replaced render statements with our service class:
      render json: SightingSerializer.new(sighting).to_serialized_json
    end
  end