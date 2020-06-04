class SightingsController < ApplicationController

    def index
    sightings = Sighting.all
    # sighting is used as a variable for all instances in sighting
    # render json: sightings.to_json(:include => {
    #   :bird => {:only => [:name, :species]},
    #   :location => {:only => [:latitude, :longitude]}
    # }, :except => [:updated_at])

    # --------------------- New Version ------------------------------

      render json:
    SightingSerializer.new(sightings).to_serialized_json

    # SightingSerializer creating a new instance with (sightings as the variable)

    # -> then its being followed by the method ( to_serialized_json)
    # -> to_serialized_json(method) : handling the inclusion and exclusion of attributes, and return the results.

    # After new instance is created by SightingSerializer.new --> to_serialized_json(method) <-- is called  on the new instance  to get our data customized and ready to go as a JSON string!

    end


    def show
        sighting = Sighting.find(params[:id])
        # using an instance variable
        # render json: @sighting.to_json(:include => {:bird => {:only =>[:name, :species]}, :location => {:only =>[:latitude, :longitude]}}, :except => [:updated_at])
        # displaying json with the values from the keys


        # --------- New Version ---------
        render json:
        SightingSerializer.new(sighting).to_serialized_json
    end
end
