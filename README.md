# Extracting a Service Class

## Learning Goals

- Remove logic from controller actions into a separate service class
- Refactor code to eliminate repetition

## Introduction

In the previous lessons, we started to see how customizing our JSON data in the
controller works but can start to get pretty complicated. It is possible for
a single controller action to render data from multiple models on our Rails
API. It is also possible to specify what we want and don't want to render.

The complication comes when we start to scale. More models, more data, more
pieces to customize until it becomes unmanageable. In this code-along, we're going
to look at building our own solution to this problem.

The files in this lesson were populated using the API-only Rails build. Run
`rails db:migrate` and `rails db:seed` to follow along.

## Initial Configuration

There are already three resources set up based on where we left off in the
previous lesson on `include`: birds, locations, and sightings. Birds and
locations are related together through sightings:

```rb
class Bird < ApplicationRecord
  has_many :sightings
  has_many :locations, through: :sightings
end
```

```rb
class Location < ApplicationRecord
  has_many :sightings
  has_many :birds, through: :sightings
end
```

```rb
class Sighting < ApplicationRecord
  belongs_to :bird
  belongs_to :location
end
```

And we left off with a messy combination of `include`, `only`, and `except` in
order to customize what attributes we wanted to render to JSON:

```rb
def show
  sighting = Sighting.find_by(id: params[:id])
  render json: sighting.to_json(:include => {
    :bird => {:only => [:name, :species]},
    :location => {:only => [:latitude, :longitude]}
  }, :except => [:updated_at])
end
```

Although this is difficult to read, it does work. With this action in place,
visiting `http://localhost:3000/sightings/2` produces the following set of data:

```js
{
  "id": 2,
  "bird_id": 2,
  "location_id": 2,
  "created_at": "2019-05-14T14:56:35.978Z",
  "bird": {
    "name": "Grackle",
    "species": "Quiscalus Quiscula"
  },
  "location": {
    "latitude": 30.26715,
    "longitude": -97.74306
  }
}
```

We can use the same render statement in an `index` action without having to change it:

```rb
class SightingsController < ApplicationController
  def index
    sightings = Sighting.all
    render json: sightings.to_json(:include => {
      :bird => {:only => [:name, :species]},
      :location => {:only => [:latitude, :longitude]}
    }, :except => [:updated_at])
  end

  def show
    sighting = Sighting.find_by(id: params[:id])
    render json: sighting.to_json(:include => {
      :bird => {:only => [:name, :species]},
      :location => {:only => [:latitude, :longitude]}
    }, :except => [:updated_at])
  end
end
```

However, the way things are presents some problems. Having to include this in
every controller action would not be very DRY. In addition, as mentioned
before, it is difficult to read, and equally difficult to write and update without
making errors.

There is also a separate issue - controllers are really just meant to act as a
relay between our models and our view, or well, our rendered JSON in this case.
If we can extract the work of customizing our JSON data and put it somewhere
else, we could keep our controller actions cleaner.

Let's resolve this issue before resolving the issue of readability. One way to
resolve this issue is to build a service class.

## Creating a Service Class

A service class is a class specific to our domain that handles some of the business
logic of the application. In this case, we are looking to handle the logic of
arranging our JSON data the way we want it.

In the `SightingsController`, we already have working render statements. Our
goal is not to change these statements, just move the work off of the controller.

To create a class we will be able to utilize in place of the current render
statements, first, we'll create a new folder within `app` called `services`:

```sh
mkdir app/services
```

Then we'll need to create a service class to use in our `SightingsController`.
Since we're specifically arranging and serving up data, and also for reasons
that will become much clearer in the next lesson, we'll create a class called
`SightingSerializer` and save it in the `services` folder as
`sighting_serializer.rb`:

```sh
touch app/services/sighting_serializer.rb
```

This can be a plain Ruby class without the need to inherit from anything:

```ruby
class SightingSerializer
end
```

Once a new class and file are created this way, you'll need to restart the Rails
server if it is running in order for `SightingSerializer` to be recognized
and available in places like `SightingsController`.

## Configuring the New Serializer

Looking back at `SightingsController`, we are currently calling the `to_json`
method on the variables `sightings` and `sighting` in the two controller
actions:

```rb
class SightingsController < ApplicationController
  def index
    sightings = Sighting.all
    render json: sightings.to_json(:include => {
      :bird => {:only => [:name, :species]},
      :location => {:only => [:latitude, :longitude]}
    }, :except => [:updated_at])
  end

  def show
    sighting = Sighting.find_by(id: params[:id])
    render json: sighting.to_json(:include => {
      :bird => {:only => [:name, :species]},
      :location => {:only => [:latitude, :longitude]}
    }, :except => [:updated_at])
  end
end
```

Remember, though, that everything following `to_json` is the same for both
actions. The goal of our new serializer class is to replace this without having
to change too much.

We will approach configuring the serializer in two steps. First, we will want to
define an `initialize` method for the class. If you recall from object-oriented
Ruby, we use the `initialize` method to set up any instance variables that we
might want to share over multiple methods. In this case, `initialize` will take
in whatever variable we're dealing with in a particular action, and store it as
an instance variable:

```ruby
class SightingSerializer

  def initialize(sighting_object)
    @sighting = sighting_object
  end

end
```

Now, whatever we pass when initializing a new instance of `SightingSerializer`
will be stored as `@sighting`. We will need access to this variable elsewhere
in the `SightingSerializer`, so an instance variable is needed here.

The second step is to write a method that will call `to_json` on this instance
variable, handling the inclusion and exclusion of attributes, and return the results. 
We will call this method `to_serialized_json`, and for now we can directly copy the 
`to_json` logic that currently exists in `SightingsController`:

```ruby
class SightingSerializer

  def initialize(sighting_object)
    @sighting = sighting_object
  end

  def to_serialized_json
    @sighting.to_json(:include => {
      :bird => {:only => [:name, :species]},
      :location => {:only => [:latitude, :longitude]}
    }, :except => [:updated_at])
  end

end
```

With this setup, once an instance of `SightingSerializer` is created, we can
call `to_serialized_json` on it to get our data customized and ready to go as
a JSON string!

Now it is time to clean up `SightingsController` and replace the original render
statements with our new service class:

```rb
class SightingsController < ApplicationController
  def index
    sightings = Sighting.all
    render json: SightingSerializer.new(sightings).to_serialized_json
  end

  def show
    sighting = Sighting.find_by(id: params[:id])
    render json: SightingSerializer.new(sighting).to_serialized_json
  end
end
```

Extraction complete! We've resolved the issue of keeping our controller clear of
excess logic by moving it to a separate class. However, we still haven't made
our `to_json` any easier to read.

## Organizing Options

In the `to_serialized_json` method, we are passing multiple options into
`to_json` when it is called. These options are just key/value pairs in a hash,
though, and we can choose to break this line up to get a better grasp of what is
actually going on. Rewriting the method without changing any functionality, we
could write:

```rb
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
```

Above, we define a variable, `options`, assigning it to a hash. We then
define two keys on that hash, `:include` and `:except`, and assign them the
same values as before. Finally, at the end of the method, instead of filling 
`to_json` with a long list of options, we pass in the `options` hash.

## Conclusion

With a fully extracted `SightingSerializer`, we were able to leave our controller
free of clutter and extra logic. We were able to write a small class and utilize
its methods multiple times, rather than repeat ourselves. Meanwhile, we now have
the space within that class to make our code as easy to understand as possible.
