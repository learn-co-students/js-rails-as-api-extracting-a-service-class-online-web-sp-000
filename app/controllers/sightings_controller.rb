class SightingsController < ApplicationController
    def index
        sightings = Sighting.all
        # NEW HOTNESS
        render json: SightingSerializer.new(sightings).to_serialized_json
        # OLD AND BUSTED
        # render json: sightings.to_json(:include => {
        #   :bird => {:only => [:name, :species]},
        #   :location => {:only => [:latitude, :longitude]}
        # }, :except => [:updated_at])
      end
     
      def show
        sighting = Sighting.find_by(id: params[:id])
        # NEW HOTNESS
        render json: SightingSerializer.new(sighting).to_serialized_json
        # OLD AND BUSTED
        # render json: sighting.to_json(:include => {
        #   :bird => {:only => [:name, :species]},
        #   :location => {:only => [:latitude, :longitude]}
        # }, :except => [:updated_at])
      end
end
