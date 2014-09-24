require 'sinatra'
require 'sinatra/reloader'

set :port, 3000
set :bind, '0.0.0.0'

class Spotinatra
	attr_accessor :songs
	
	def initialize
		@songs = []
	end
	
	def add_song(name, author)
    @songs << [name, author]
  end

end

list = Spotinatra.new # list ||= Spotinatra.new
list.songs = [["Beatles", "Because"], ["Peret", "Borriquito"], ["Depeche mode", "Enjoy the silence"], ["And One", "Military fashion show"], ["Dream Sequence", "Outside looking in"] ]

get '/' do
	@list_to_print = list.songs
	erb :index
end

post "/new" do
	author = params[:author]; name = params[:name] # Gets info
  
  list.add_song(author, name) if list.songs.size < 6   # Stores info 
  
  if list.songs.size < 6 # Redirect   
    	redirect to('/')
  else
    redirect to('/enough')
  end	
end
	
get '/find/:artist' do
		@find = (list.songs.select { |artist, _| artist == params[:artist] })
		p @find
		puts
		p list.songs
		erb :find
end

get '/enough' do
	if list.songs.size < 6 
		redirect to('/')
	else
		@songs_quantity = list.songs.size
		erb :enough
	end
end

# __END__
# curl -L localhost:3000/new/Beatles/Because
# curl -L localhost:3000/new/Peret/Borriquito
# curl -L localhost:3000/new/Depeche%20Mode/Enjoy%20the%20silence
# curl -L localhost:3000/new/Nouvelle Vague/In a manner of speaking
# curl -L localhost:3000/new/Frank%20Sinatra/My%20way
# curl -L localhost:3000/new/Frank Sinatra/My other way



