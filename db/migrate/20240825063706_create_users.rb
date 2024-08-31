class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.integer :position, null: false, default: 10
      t.integer :department_id, null: false, default: 1
      t.integer :state, null: false, default: 0

      t.timestamps
    end
  end
end
