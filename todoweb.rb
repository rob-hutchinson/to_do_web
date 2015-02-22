require 'sinatra/base'
require "pry"
require "./db/setup"
require "./lib/all"

class Todoweb < Sinatra::Base
  # set :bind, '0.0.0.0'
  # set :port, '3000'

  def current_user
    username = request.env["HTTP_AUTHORIZATION"]
    User.find_or_create_by! name: username.downcase.capitalize
  end

# Adds item to indicated :list_name (creating the list if necessary).
# User must send a header of their username as authentication
# Will not allow a user to make an "all" list so the /lists/all get request works
# Optionally pass a param of "due_date" to set the item's due_date when it is created
  post "/lists/:list_name" do
    unless params[:list_name] == "all"
      a = current_user.lists.find_or_create_by! list_name: params[:list_name]
      b = a.add params["item"], a.id, current_user.id
      if params["due_date"]
        b.due! params["due_date"]
      end
    else
      "Invalid list name"
    end
  end

# Authenticated user may adjust a given item's due date or mark it done
  patch "/items/:id" do
    item = Item.find(params[:id])
    if current_user.authorize! item  
      if params["due_date"]
        item.due! params["due_date"]
      end
    
      if params["done"]
        item.finished!
      end
    else
      "Invalid Authorization!"
    end
  end

# Returns all items for authenticated user
  get "/lists/all" do
    current_user.items.to_json
  end

# Returns all items on an authenticated user's given :list
  get "/lists/:list" do
    list = current_user.lists.find_by(list_name: params[:list])
    if list == nil
      "No such list found"
    else
      list.items.to_json
    end
  end

# Returns the names of each list that is linked with authenticated user
  get "/lists" do
    list = current_user.lists
    list_names = []
    list.find_each do |x|
      list_names << x.list_name.to_json
    end
    list_names
  end

# Returns all incomplete items for a particular user
  get "/items" do
    current_user.items.where(i_done: false).to_json
  end
end

Todoweb.run!