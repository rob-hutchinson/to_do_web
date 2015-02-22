class User < ActiveRecord::Base
  has_many :lists
  has_many :items

  def authorize! thing
    if thing.id == self.id
      true
    end
  end
end