class BirdsController < ApplicationController
  has_many :sightings
  has_many :locations, through: :sightings
end
