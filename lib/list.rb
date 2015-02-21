class List < ActiveRecord::Base
  has_many :items
  belongs_to :user

  
  def add name, list_id, user_id
    Item.create! item: name, list_id: list_id, user_id: user_id
  end
end