class SearchesController < ApplicationController
# note that all instance variable will be acessable files( or maybe more likely there own coresponding views) withing the view folders
  def index# default home page
    @searches = Search.all # @ searches is an instance variable which retreives ans contains all of the searhes which have been saved to the database
  end
  
  def show # shows an individual post which has been saved to the database 
    @search = Search.find(params[:id])# @ search is an instance variable which will contain specific search which will be selected by the user
  end
  
  def new # displys a form to create a search
    require 'oauth'
    require 'json'
    @search = Search.new
    
    api_key = "64t3dlhlblzr"
    api_secret="7OS3jy75E5PexgYt"
    user_token="52e76aba-c641-43a8-b93d-8af30c1cd9b8"
    user_secret="5e48a76d-99da-40f9-bd56-25a452a94881"
    
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
    fields = ['first-name', 'last-name', 'headline', 'industry', 'num-connections']
    
    # Make a request for JSON data
    json_txt = access_token.get("/v1/people/~:(#{fields})", 'x-li-format' => 'json').body
    @profile = JSON.parse(json_txt)
    
  end
  
  def create # saves a search into the database
    
    @search = Search.new(params[:search])
    
    if @search.save
      redirect_to index_path, :notice => "Your Search has been Saved"
    else
      render "new"
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
    redirect_to searches_path,:notice => "Your Search has been Deleted"
  end
  
end
