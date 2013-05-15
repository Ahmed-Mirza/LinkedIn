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
   
    @search = Search.new
    
  end
  
  def create # saves a search into the database
    
    @search = Search.new(params[:search])
    $currentSearch="mian"
    if @search.save
      redirect_to results_display_path, :notice => "Your Search has been Saved"
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
