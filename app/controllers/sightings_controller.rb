class SightingsController < ApplicationController

  #old code 
  # def index
  #   sightings = Sighting.all
  #   render json: sightings.to_json(:include => {
  #     :bird => {:only => [:name, :species]},
  #     :location => {:only => [:latitude, :longitude]}
  #     }, :except => [:updated_at])
  # end

  #DRY'd up code using sighting serializer and #to_serialized_json 
  def index
    sightings = Sighting.all
    render json: SightingSerializer.new(sightings).to_serialized_json
  end
  
  # def show
  #   sighting = Sighting.find_by(id: params[:id])
  #   render json: sighting.to_json(:include => {
  #     :bird => {:only => [:name, :species]},
  #     :location => {:only => [:latitude, :longitude]}
  #     }, :except => [:updated_at])
  #   end

    def show
      sighting = Sighting.find_by(id: params[:id])
      render json: SightingSerializer.new(sighting).to_serialized_json
    end
    
end
