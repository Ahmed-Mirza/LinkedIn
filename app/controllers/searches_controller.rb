class SearchesController < ApplicationController
# note that all instance variable will be acessable files( or maybe more likely there own coresponding views) withing the view folders
  def search_history# default home page
    @searches = Search.all # @ searches is an instance variable which retreives ans contains all of the searhes which have been saved to the database
  end
  
  def show # shows an individual post which has been saved to the database 
    @search = Search.find(params[:id])# @ search is an instance variable which will contain specific search which will be selected by the user
  end
  
  def results
    
  end
  
  def search_page # displys a form to create a search
    require 'oauth'
    require 'json'
    @search = Search.new
    
    api_key = "64t3dlhlblzr"
    api_secret="7OS3jy75E5PexgYt"
    user_token="58f485ba-348e-4aa5-9b0c-23c301e86675"
    user_secret="016b789c-23c8-459f-b57e-58cf8e28d565"
    
    # Specify LinkedIn API endpoint
    consumer_options = { :site => "https://api.linkedin.com",
                     :authorize_path => "/uas/oauth/requestToken",
                     :request_token_path => "/uas/oauth/accessToken",
                     :access_token_path => "/uas/oauth/authorize" }
    
    # Use your API key and secret to instantiate consumer object
    consumer = OAuth::Consumer.new(api_key, api_secret, consumer_options)
    
    # Use your developer token and secret to instantiate access token object
    access_token = OAuth::AccessToken.new(consumer, user_token, user_secret)
    
    # Pick some fields
    fields = ['first-name', 'last-name', 'headline', 'industry', 'num-connections'].join(',')
    
    # Make a request for JSON data
    @json_txt = access_token.get("/v1/people/~:(#{fields})", 'x-li-format' => 'json').body
    @profile = JSON.parse(@json_txt)
    
  end
  
  def create # saves a search into the database
    
    @search = Search.new(params[:search])
    
    if @search.save
      redirect_to root_path, :notice => "Your Search has been Saved"
    else
      render "search_page"
    end
  end
  #***********************************************
  # Will not be useing edit update or destroy at 
  # the moment only required to store and be able
  # to bring up what is being searched
  #***********************************************  
  def edit # displays a form to edit a search
    
  end

  def update # updates a search in the database after editing it 
    
  end
  
  def destroy # deleates a searh from the database
    @search = Search.find(params[:id])
    @search.destroy
    redirect_to history_path,:notice => "Your Search has been Deleted"
  end
  
end
