class UpdateItem < ActiveRecord::Migration
  def change
    rename_column(:items, :t_done, :i_done)
  end
end
