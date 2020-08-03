class SightingSerializer
    def initialize(sighting_object)
        @sighting = sighting_object
    end

    def to_serialized_json
        @sighting.to_json(:include =>{
            :bird => {:only => [:name, :species]},
            :location => {:only => [:latitude, :logitude]}
        }, :execpt => [:updated_at])
    end
end