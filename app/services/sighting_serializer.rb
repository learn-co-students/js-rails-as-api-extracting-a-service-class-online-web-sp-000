class SightingSerializer

    def initialize(sighting_obj)
        @sighting = sighting_obj
    end

    def to_serialized_json
        options = {
          include: {
            bird: {
                only: [:name, :species]
            },
            location: {
                only: [:latitude, :longitude]
            }
          }, 
          except: [:updated_at]
        }
            @sighting.to_json(options)
        
    end
end