get '/' do
  if current_user
    @users = User.all
  end
  erb :index
end

#----------- SESSIONS -----------

get '/sessions/new' do
  # render sign-in page 
  erb :sign_in
end

post '/sessions' do
  # sign-in
  email = params[:email]
  password = params[:password]

  user = User.where(email: email).first
  if user.password == params[:password]
    session[:user] = user.id
  end
  redirect to('/')
end

delete '/sessions/:id' do
  # sign-out -- invoked via AJAX
  session[:user] = nil
end

#----------- USERS -----------

get '/users/new' do
  # render sign-up page
  erb :sign_up
end

post '/users' do
  # sign-up a new user
  name = params[:name]
  email = params[:email]
  password = params[:password]

  user = User.new({name: name, email: email})
  user.password = params[:password]
  user.save!

  if user.errors
    session[:errors] = user.errors.full_messages
  end
  session[:user] = user.id
  redirect to('/')
end
