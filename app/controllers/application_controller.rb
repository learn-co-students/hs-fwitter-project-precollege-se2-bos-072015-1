require './config/environment'
require './app/models/tweet'
require './app/models/user'
require 'pry'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
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

  get '/users' do
    @users = User.all
    erb :users
  end

  post '/users' do
    new_user = User.new(:username => params[:username], :email => params[:email], :age => params[:age], :profile_pic => params[:profile_pic])
    new_user.save
    redirect ('/users')
  end

end
