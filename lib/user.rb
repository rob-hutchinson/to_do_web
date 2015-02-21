class User < ActiveRecord::Base
  has_many :lists
  has_many :items

  def authorize! thing
    binding.pry
    if thing.id == self.id
      true
    end
  end
end