class LocationSerializer
  include FastJsonapi::ObjectSerializer
  attributes :latitude, :longitude
end
