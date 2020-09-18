#specific to our domain 
#handles business logic of application
#this handles the logic of arranging our JSON data
# mkdir app/services (creates folder within app called services)
# touch app/services/sighting_serializer.rb creates a service class to use in our SightingsController 
# restart rails server 
# leave our controller free of clutter and extra logic:
class SightingSerializer

    def initialize(sighting_object)
        @sighting = sighting_object
      end

      #logic in sightingscontroller:
      def to_serialized_json
        options = { #define variable options, assigning it to a hash
          include: { #define two keys on that hash, include and except
            bird: {
              only: [:name, :species]
            },
            location: {
              only: [:latitude, :longitude]
            }
          },
          except: [:updated_at],
        }
        @sighting.to_json(options) #pass in options hash 
      end

end

#define initialize method - sets up an instance variable that we might want to share over multiple methods
# store it as an instance variable 