class SightingSerializer

  #setting up our instance variable to reuse
  def initialize(sighting_object)
    @sighting = sighting_object
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
      except: [:updated_at],
    }
    #note we are passing in the options hash here instead of passing in the whole hash
    @sighting.to_json(options)
  end

end
