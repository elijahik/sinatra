require 'sinatra'

set :port, 3000
set :bind, '0.0.0.0'

class Spotinatra
	attr_accessor :songs
	def initialize
		@songs = []

	end
end

list_of_songs = Spotinatra.new

get '/' do
	list_of_songs.songs.inspect
	# erb :index
end

get "/songs/new/:artist/:song" do
	p params
	if list_of_songs.songs.size < 5
	  list_of_songs.songs << [params[:artist], params[:song]]
	  redirect to('/')
		# " #{params[:artist]} #{params[:song]}"
	else
		redirect to('/enough')
	end

end
# , will be POST, and will have both “name” and “artist”
	
get '/enough' do
	"IS WORTH F**ING NOTHING"
end


