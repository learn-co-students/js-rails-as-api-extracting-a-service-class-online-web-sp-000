class SightingSerializer

   def initialize(sighting_object)
      @sighting = sighting_object
   end

   # whatever you pass when initializing a new instance of SightingSerializer
   # will be stored as @sighting.

   # You will need to access to this variable elsewhere in the SightingSerializer,
   # so an instance variable is needed here.

   # The second step is to write a method
   # that will call to_json on this instance variable,
   # handling the inclusion and exclusion of attributes, and return the results.

   # You will call this method to_serialized_json,
   # and for now you can directly copy the to_json logic
   # that currently exists in SightingsController:

   # def to_serialized_json
   #    @sighting.to_json(:include => {
   #       :bird => {:only => [:name, :species]},
   #       :location => {:only => [:latitude, :longitude]}
   #    }, :except => [:updated_at])
   # end

   # A more organized approach to displaying the data:

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

end
