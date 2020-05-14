#! Now, whatever we pass when initializing a new instance of SightingSerializer will be stored as @sighting. We will need access to this variable elsewhere in the SightingSerializer, so an instance variable is needed here.

class SightingSerializer
      def initialize(sighting_object)
        @sighting = sighting_object
      end
end