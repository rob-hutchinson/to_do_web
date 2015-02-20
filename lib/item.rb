class Item < ActiveRecord::Base
  
  belongs_to :list
  
  def finished!
    update i_done: true
  end

  def due! date
    update i_due_date: Date.parse(date)
  end

end  