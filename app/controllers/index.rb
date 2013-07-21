get '/' do
  # render home page
 #TODO: Show all users if user is signed in
  if session[:user]
    @users = User.all?
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
end

delete '/sessions/:id' do
  # sign-out -- invoked via AJAX
end

#----------- USERS -----------

get '/users/new' do
  # render sign-up page
  erb :sign_up
end

post '/users' do
  # sign-up a new user
  name = params['user'['name']]
  email = params['user'['email']]
  password = params['user'['password']]
  password_salt = BCrypt::Engine.generate_salt
  password_hash = BCrypt::Engine.hash_secret(password, password_salt)

  user = User.create({ name: name, email: email, password_hash: password_hash })
  if user.errors
    session[:errors] = user.errors.full_messages
  end
end
