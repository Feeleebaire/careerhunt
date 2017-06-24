class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]
  require "json"
  require "rest-client"



  def home

  response = RestClient.post( "https://api.producthunt.com/v1/oauth/token",
    {
      :client_id => ENV['clientid'],
      :client_secret => ENV['clientsecret'],
      :grant_type => "client_credentials"
      }
    )
    acces_token = JSON.parse(response)
    your_access_token = acces_token['access_token']


    query = RestClient.get 'https://api.producthunt.com/v1/categories', {:Authorization => "Bearer #{your_access_token}"}
    @users = JSON.parse(query)

  end
end


