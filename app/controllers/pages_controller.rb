class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]
  require "json"
  require "rest-client"



  def home
  #demande d'accès à l'API
  response = RestClient.post( "https://api.producthunt.com/v1/oauth/token",
    {
      :client_id => ENV['clientid'],
      :client_secret => ENV['clientsecret'],
      :grant_type => "client_credentials"
      }
    )
  acces_token = JSON.parse(response)
  #Récupération de l'accès token
  your_access_token = acces_token['access_token']

  #Requête pour récupérer les catégories
  query = RestClient.get 'https://api.producthunt.com/v1/categories', {:Authorization => "Bearer #{your_access_token}"}
  @users = JSON.parse(query)

  #Requête pour récupérer les posts
  query_posts = RestClient.get 'https://api.producthunt.com/v1/posts', {:Authorization => "Bearer #{your_access_token}"}
  @posts = JSON.parse(query_posts)

  end
end


