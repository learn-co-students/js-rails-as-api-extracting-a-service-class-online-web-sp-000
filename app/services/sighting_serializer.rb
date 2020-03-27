class SightingSerializer

  def initialize(sighting_object)
    @sighting = sighting_object
  end

  def to_serialized_json
    options = {
        include: {
            bird: {
                only: [:name, :location]
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