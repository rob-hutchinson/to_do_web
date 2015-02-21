require 'sinatra/base'
require "pry"
require "./db/setup"
require "./lib/all"

class Todoweb < Sinatra::Base
  # set :bind, '0.0.0.0'
  # set :port, '3000'

  def current_user
    username = request.env["HTTP_AUTHORIZATION"]
    User.find_or_create_by! name: username
  end


  post "/lists/:list_name" do
    a = current_user.lists.find_or_create_by! list_name: params[:list_name]
    b = a.add params["item"], a.id
    if params["due_date"]
      b.due! params["due_date"]
    end
  end


  patch "/items/:id" do
    a = Item.find(params[:id])
    
    if params["due_date"]
      a.due! params["due_date"]
    end
    
    if params["done"]
      a.finished!
    end
  end

  get "/lists/:list" do
  end

end

Todoweb.run!