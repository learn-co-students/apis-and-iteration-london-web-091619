require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character_name)
  character_data = RestClient.get('http://swapi.co/api/people/1')
  response_string = RestClient.get('http://www.swapi.co/api/people/')
  response_hash = JSON.parse(response_string)["results"]

  film_array = []
  response_hash.each do |character|
    if character["name"] == character_name
      character["films"].each do |film|
        film_string = RestClient.get(film)
        film_hash = JSON.parse(film_string)
        film_array << film_hash 
        # binding.pry
        # puts "Done"
      end 

    end 

  end 
  film_array
end 

  #   films_array = get_character_movies_from_api(character)
  #   print_movies(films_array
  # end 
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `print_movies`
  #  and that method will do some nice presentation stuff like puts out a list
  #  of movies by title. Have a play around with the puts with other info about a given film.


def print_films(films)
  puts get_character_movies_from_api(films)
end

def show_character_movies(character)
  films = get_character_movies_from_api(character)
  print_films(films)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
