require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character_name)
  #make the web request
  # iterate over the response hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `print_movies`
  #  and that method will do some nice presentation stuff like puts out a list
  #  of movies by title. Have a play around with the puts with other info about a given film.

  response_string = RestClient.get('http://www.swapi.co/api/people/')
  response_hash = JSON.parse(response_string) 
  character_list = get_results(response_hash)
  found_character = find_character(character_list, character_name)
  found_films = find_films(found_character)
  got_films = get_films(found_films)
  return got_films
  
 end

 def get_results(response_hash)
  response_hash["results"]
 end

  def find_character(character_list, character_name)
    character_list.each do |character_loop|
      character = get_character_name(character_loop)
      if character == character_name
        return character_loop
      end
    end
  end
  

  def get_character_name(character_loop)
    character_loop["name"]
  end

  def get_films(found_films)
    api_films = []
    found_films.each do |api|
      api_films.push(JSON.parse(RestClient.get(api)))
  end
  return api_films
 end


  def find_films(found_character)
    found_character["films"]
  end

 def print_movies(films)
   print_films = title_finder(films)
   print_films.each do |film|
    puts(film)
   end
 end

 def title_finder(films)
  titles = []
  films.each do |film|
    titles.push(film["title"])
 end
 return titles
 end

 def show_character_movies(character)
  films = get_character_movies_from_api(character)
  print_movies(films)
 end


## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
