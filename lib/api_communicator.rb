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
      end
    end
  end
  film_array
end

def print_films(films)
  films.each do |film|
    puts film['title']
  end
end

def show_character_movies(character)
  films = get_character_movies_from_api(character)
  print_films(films)
end


## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
