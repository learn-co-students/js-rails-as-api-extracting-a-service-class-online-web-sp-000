class SightingSerializer 

    def initialize(sighting_object)
        @sighting = sighting_object
    # careful. heres what it actually does. 
    #say i have an instance of the class. x = Sightingserializer.new(sighting_object)
    #simialr to Bird.new(name, species) 
    # u might think these are attributes. super close. https://learn.co/tracks/full-stack-web-development-v8/module-6-object-oriented-ruby/section-4-object-properties/object-attributes
    #attributes are just instance varaibles but also with getters and setters
    #. now other methods in x can access this object by calling @sighting
    end

    def to_serialized_json
        options = {
            :include => {
                :bird => {
                    :only => [:name, :species]
                },
                :location => {
                    :only => [:latitude, :longitude]
                }
            },
           :except => [:updated_at]
        }    
        
        @sighting.to_json(options)
    end


end
