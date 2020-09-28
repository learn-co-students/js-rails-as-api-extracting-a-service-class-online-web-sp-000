class SightingSerializer

# 1. define an initialize method to set up any intance vars to be used across multiple methods

    def initialize(sighting_object)
        @sighting = sighting_object
    end

    # 2. write a method that will call to_json on this instance variable. it will handle inclusion or exclusion of any attributes and return the results

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

    # Once an instance of SightingSerializer is created, we can call to_serialized_json on it to customize our data and prepped as a JSON string.

end