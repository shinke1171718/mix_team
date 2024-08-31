class CreateDepartments < ActiveRecord::Migration[7.1]
  def change
    create_table :departments do |t|
      t.string :name
      t.integer :position, null: false, default: 99
    end
  end
end
