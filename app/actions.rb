# CONTROLLER
# Actions/Routes 

helpers do 
  def current_user 
    User.find_by(id: session[:user_id])
  end 
end 

# Handle an HTTP GET request for the path '/'
get '/' do
  @finstagram_posts = FinstagramPost.order(created_at: :desc)
  erb(:index)
end 

# Handle an HTTP GET request for the path '/signup'
get '/signup' do 
  @user = User.new
  erb (:signup)
end

# Handle an HTTP POST request for the path '/signup'
post '/signup' do
  
  email = params[:email]
  avatar_url = params[:avatar_url]
  username = params[:username]
  password = params[:password]
  
  @user = User.new ({ email: email, avatar_url: avatar_url, username: username, password: password })

  if @user.save
    redirect to('/login')

  else
    erb(:signup)
  end

end

# Handle an HTTP GET request for the path '/login'
get '/login' do
  erb(:login)
end


# Handle an HTTP POST request for the path '/login'
post '/login' do
  username = params[:username]
  password = params[:password]
  
  @user = User.find_by(username: username)
 
  if @user && @user.password == password
    session[:user_id] = @user.id
    redirect to('/')
    else 
      @error_message ="Login failed."
      erb(:login)
    end
end

get '/logout' do
  session[:user_id] = nil
  redirect to('/')
end 




