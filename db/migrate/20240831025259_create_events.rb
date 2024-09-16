class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.string :title, null: false
      t.integer :max_group_size, null: false
      t.integer :min_group_size, null: false
      t.integer :state, default: 1, null: false
      t.text :memo
      t.datetime :event_date, null: false
      t.integer :invitees_count, default: 0, null: false
  
      t.timestamps
    end
  end  
end
