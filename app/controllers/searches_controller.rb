class SearchesController < ApplicationController
# note that all instance variable will be acessable files( or maybe more likely there own coresponding views) withing the view folders
  def index# default home page
    @searches = Search.all # @ searches is an instance variable which retreives ans contains all of the searhes which have been saved to the database
  end
  
  def show # shows an individual post which has been saved to the database 
    @search = Search.find(params[:id])# @ search is an instance variable which will contain specific search which will be selected by the user
  end
  
  def new # displys a form to create a search
    @search = Search.new
    
    api_key = "64t3dlhlblzr"
    api_secret="7053jy75E5PexgYt"
    user_token="d9708047-42b0-4177-b76c-f961e350de75"
    user_secret="8931810e-91b7-40de-b093-de336e42b706"
    
    # Specify LinkedIn API endpoint
    configuration = { :site => 'https://api.linkedin.com' }
    
    # Use your API key and secret to instantiate consumer object
    consumer = OAuth::Consumer.new(api_key, api_secret, configuration)
    
    # Use your developer token and secret to instantiate access token object
    access_token = OAuth::AccessToken.new(consumer, user_token, user_secret)
    
    # Make call to LinkedIn to retrieve your own profile
    response = access_token.get("http://api.linkedin.com/v1/people/~?format=json")
    
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
