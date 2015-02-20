class List < ActiveRecord::Base
  has_many :items
  belongs_to :user

  
  def add name, list_id
    Item.create! item: name, list_id: list_id
  end
end