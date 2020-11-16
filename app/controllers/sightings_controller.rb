class SightingsController < ApplicationController
    def index
        sightings = Sighting.all
        '''
        render json: sightings.to_json(:include => {
          :bird => {:only => [:name, :species]},
          :location => {:only => [:latitude, :longitude]}
        }, :except => [:updated_at])
        '''
        render json: SightingSerializer.new(sightings).to_serialized_json

    end
    
    def show
        # @sighting = Sighting.find(params[:id])
        # render json: @sighting.to_json(:include => {:bird => {:only =>[:name, :species]}, :location => {:only =>[:latitude, :longitude]}}, :except => [:updated_at])
        sighting = Sighting.find_by(id: params[:id])
        '''
        render json: sighting.to_json(:include => {
          :bird => {:only => [:name, :species]},
          :location => {:only => [:latitude, :longitude]}
        }, :except => [:updated_at])
        '''
        render json: SightingSerializer.new(sighting).to_serialized_json
    end
    
    def initialize(sighting_object)
        @sighting = sighting_object
    end
    
    def to_serialized_json
        '''
        @sighting.to_json(:include => {
          :bird => {:only => [:name, :species]},
          :location => {:only => [:latitude, :longitude]}
        }, :except => [:updated_at])
        '''
        options = {
            include: {
              bird: {
                only: [:name, :species]
              },
              location: {
                only: [:latitude, :longitude]
              }
            },
            except: [:updated_at],
        }
        @sighting.to_json(options)
    end
end
