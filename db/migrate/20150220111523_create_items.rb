class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :item
      t.datetime :i_due_date
      t.boolean :t_done, :default => false
      t.integer :list_id
      t.timestamps
    end
  end
end
