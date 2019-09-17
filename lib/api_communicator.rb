require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character_name)
 films_array = []
 response_string = RestClient.get('http://www.swapi.co/api/people/')
 response_hash = JSON.parse(response_string)
 results_array = response_hash["results"]
 results_array.each do |result_element|
   if result_element["name"] == character_name
     return result_element["films"]
   end
 end
end

def print_movies(films)
 film_titles = []
 if films.empty? 
  puts "nope"
 else
 films.each do |films_elememt|
   raw_film_link = RestClient.get(films_elememt)
   parsed_film_link = JSON.parse(raw_film_link)
   puts parsed_film_link["title"]
 end
end
end

def show_character_movies(character)
 films = get_character_movies_from_api(character)
 print_movies(films)
end




