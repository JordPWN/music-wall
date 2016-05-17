# Homepage (Root path)
helpers do

  def current_user
    # session['whatever'] will be nil if it's not present in the session
    user_id = session['user_id']
    user_id.nil? ? nil : User.find(user_id)
  end

  def logged_in?
    !current_user.nil?
  end

end

before '/tracks/*' do
  # halt 403 unless logged_in?
  redirect '/403' unless logged_in?
end

get '/tracks/:id/reviews' do
  @track = Track.find params[:id]
  erb :'tracks/reviews'
end

get '/tracks/:id/review_form' do
  @track = Track.find params[:id]
  erb :'tracks/review_form'
end

get '/vote_track' do
  @track = Track.find(params[:track_id])
  @upvote = Upvote.where(track: @track).where(user: current_user)
  @voted_on = Upvote.where(user: current_user)
  content_type :json
  if @upvote.empty?
    Upvote.create(track: @track, user: current_user)
  else
    #{ error: "You've already voted on this track." }.to_json
    @upvote.first.destroy#where returns an array. Grab the first (and only) element
  end
  {number_upvotes: @track.upvotes.count, voted_on: @voted_on}.to_json
  # {voted: @upvote}.to_json
  # json test: "yahhh"
end


get '/signup' do
  erb :signup
end

post '/signup' do
  @user = User.new(
    username: params[:username],
    email: params[:email],
    password: params[:password]
    )
  @user.save
  session['user_id'] = @user.id
  redirect "/tracks"
end

get '/' do
  erb :index
end

get '/login' do 
  erb :login
end

post '/login' do
  u = User.find_by(email: params[:email])
  if !u.nil? && u.password == params[:password]
    session['user_id'] = u.id
    redirect to('/')
  else
    # not found
    session['notice'] = 'could not log you in, check email or password'
    redirect to('/')
  end
end

get '/logout' do
  session['user_id'] = nil
  redirect to('/')
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
  @track = Track.find params[:id]
  erb :'tracks/show'
end

post '/tracks' do
  @track = Track.new(
    song_title: params[:song_title],
    artist:  params[:artist],
    url: params[:url],
    user_id: current_user.id
  )
  @track.save
  redirect '/tracks'
end
