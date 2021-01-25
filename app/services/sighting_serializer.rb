class SightingSerializer
  def index
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
    @sighting.to_json(options)
  end
  
    sightings = Sighting.all
    render json: sightings.to_json(:include => {
      :bird => {:only => [:name, :species]},
      :location => {:only => [:latitude, :longitude]}
    }, :except => [:updated_at])
  end
 
  def show
    sighting = Sighting.find_by(id: params[:id])
    render json: SightingSerializer.new(sighting).to_serialized_json
  end
end