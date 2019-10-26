class SightingsController < ApplicationController
    def show
        @sighting = Sighting.find(params[:id])
        bada bing bada swoon
        render json: @sighting.to_json(:include => {:bird => {:only =>[:name, :species]}, :location => {:only =>[:latitude, :longitude]}}, :except => [:updated_at])
    end
end
