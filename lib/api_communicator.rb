require 'rest-client'
require 'json'
require 'pry'

def get_character_from_api(character_name)
  response_string = RestClient.get('http://www.swapi.co/api/people/')
  response_hash = JSON.parse(response_string)['results']
  response_hash.select { |character| character['name'].downcase == character_name }.first
end

def get_films_from_character(character_hash)
  films = []
  character_hash['films'].each do |film|
    film_string = RestClient.get(film)
    film_hash = JSON.parse(film_string)
    films << film_hash
  end
  films
end

def print_films(films)
  films.each do |film|
    puts film['title']
  end
end

def show_character_movies(character)
  character_hash = get_character_from_api(character)
  films = get_films_from_character(character_hash)
  print_films(films)
end
