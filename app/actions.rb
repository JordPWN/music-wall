# Homepage (Root path)
get '/' do
  erb :index
end


get '/tracks' do
	@tracks = Track.all
	erb :'tracks/index'
end

get '/tracks/new' do
	@track = Track.new
  erb :'tracks/new'
end

get '/tracks/:id' do
  @track = Tracks.find params[:id]
  erb :'tracks/show'
end

post '/tracks' do
  @track = Track.new(
    song_title: params[:song_title],
    author:  params[:author]
  )
  @track.save
  redirect '/tracks'
end