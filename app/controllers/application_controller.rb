require './config/environment'
require './app/models/tweet'
require 'pry'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end
  
  get '/' do
    # tweet1 = Tweet.new("dfenjves", "Hello everyone!!")
    # tweet2 = Tweet.new("lyel", "I'm hungry!!")
    # tweet3 = Tweet.new("vanessa", "Me too!!")
    @tweets = Tweet.all_messages
    erb :tweets
  end

  post '/tweets' do
    # puts params
    # binding.pry
    # {"user"=>"Jackson", "message"=>"I don't know what to tweet."}
    new_tweet = Tweet.new(params[:user],params[:message])
    redirect ('/')
  end

end
