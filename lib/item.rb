class Item < ActiveRecord::Base
  
  belongs_to :list
  belongs_to :user
  
  def finished!
    update i_done: true
  end

  def due! date
    update i_due_date: Date.parse(date)
  end

end  