class SightingSerializer
  include FastJsonapi::ObjectSerializer
  attributes :created_at, :bird, :location
  belongs_to :bird
  belongs_to :location
end
