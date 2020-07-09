class SightingsController < ApplicationController
    def show
        @sighting = Sighting.find(params[:id])
        render json: @sighting.to_json(:include => {:bird => {:only =>[:name, :species]}, :location => {:only =>[:latitude, :longitude]}}, :except => [:updated_at])
    end
    class Location < ApplicationRecord
  has_many :sightings
  has_many :birds, through: :sightings
end
end
