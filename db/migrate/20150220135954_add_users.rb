class AddUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
    end

    add_column :lists, :user_id, :integer
  end
end
