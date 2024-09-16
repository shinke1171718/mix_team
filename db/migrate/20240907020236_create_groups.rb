class CreateGroups < ActiveRecord::Migration[7.1]
  def change
    create_table :groups do |t|
      t.references :event, null: false, foreign_key: true
      t.string :group_name, null: false
      t.integer :sort_order, null: false, default: 0
      t.timestamps
    end
  end
end
