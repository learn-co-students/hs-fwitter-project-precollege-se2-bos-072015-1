require './config/environment'
require './app/models/tweet'
require './app/models/user'
require 'pry'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "fwitter"
  end

  get '/' do
    @tweets = Tweet.all
    @users = User.all
    erb :tweets
  end

  post '/tweets' do
    new_tweet = Tweet.new(:user_id => params[:user_id], :message => params[:message])
    new_tweet.save
    redirect ('/')
  end

  get '/login' do
    erb :login
  end

  post '/login' do
    @user = User.find_by(:username => params[:username], :email => params[:email])
    if @user
      session[:user_id] = @user.id
      redirect('/')
    else
      erb :error
    end
  end

  get '/logout' do
    session[:user_id] = nil
    redirect('/login')
  end

  get '/users' do
    @logged_in_user = User.find(session[:user_id])
    @users = User.all
    erb :users
  end

  post '/users' do
    puts params
    new_user = User.new(:username => params[:username], :email => params[:email], :age => params[:age], :profile_pic => params[:profile_pic])
    new_user.save
    session[:user_id] = new_user.id
    redirect ('/users')
  end

end
