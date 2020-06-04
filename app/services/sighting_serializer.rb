class SightingSerializer

  def initialize(sighting_object)
    @sighting = sighting_object
  end

  def to_serialized_json
    # @sighting.to_json(:include => {
    #   :bird => {:only => [:name, :species]},
    #   :location => {:only => [:latitude, :longitude]}
    # }, :except => [:updated_at])
    #


    # ------------------ New Version ----------------
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


    # we use this process in order to make it more understandable for our code within the other actions that are rendering json.
  end

end
