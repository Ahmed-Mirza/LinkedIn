class ResultsController < ApplicationController
  
  def results
    require 'oauth'
    require 'json'
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
   
    loco =$currentSearch.to_str
    # Make a request for JSON data
    @json_txt = access_token.get("/v1/people-search?keywords=#{loco}", 'x-li-format' => 'json').body
    @profile = JSON.parse(@json_txt)

    $i=0 
    $num= @profile["people"]["_count"].to_i
    while $i< $num do 
      first = @profile["people"]["values"][$i]["firstName"]
      last = @profile["people"]["values"][$i]["lastName"]
      iD=@profile["people"]["values"][$i]["id"]
      $i +=1 
      #@result = Result.new(id:@profile["people"]["values"][$i]["id"],firstName:@profile["people"]["values"][$i]["firstName"],lastName:@profile["people"]["values"][$i]["lastName"])
      #@result.save
    end
 # @results=Result.all
  end
  
  def create
    
  end
  
end
