class BirdsController < ApplicationController
  def index
    bird = Bird.all
    render json: bird, except: [:created_at, :updated_at]
  end
end
