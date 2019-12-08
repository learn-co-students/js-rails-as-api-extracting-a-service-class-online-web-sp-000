class SightingSerializer
  # Sighting has to be singular? why? is it part of how services work?

  def initialize(sighting_object)
    @sighting = sighting_object
  end

  def to_serialized_json
    # @sighting.to_json(
      # :include => {
      #   :bird => {:only => [:name, :species]},
      #   :location => {:only => [:latitude, :longitude]}
      # }),
      # :except => [:updated_at]
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
    self.to_json(options)
  end

end
