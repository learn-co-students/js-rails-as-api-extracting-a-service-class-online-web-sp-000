class SightingSerializer
    def initialize(sighting_object)
        @sighting = sighting_object
      end

      def to_serialized_json
        # @sighting.to_json(:include => {
        #   :bird => {:only => [:name, :species]},
        #   :location => {:only => [:latitude, :longitude]}
        # }, :except => [:updated_at])

        #rewritten as to handle differently:
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


# in effect the idea here is to reduce all of this in sightings controller:
# def index
#     sightings = Sighting.all
#     render json: sightings.to_json(:include => {
#       :bird => {:only => [:name, :species]},
#       :location => {:only => [:latitude, :longitude]}
#     }, :except => [:updated_at])
#   end
 
#   def show
#     sighting = Sighting.find_by(id: params[:id])
#     render json: sighting.to_json(:include => {
#       :bird => {:only => [:name, :species]},
#       :location => {:only => [:latitude, :longitude]}
#     }, :except => [:updated_at])
#   end