class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.float :price
      t.string :status, :default => "active"
      t.text :description
      t.integer :user_id

      t.timestamps
    end
  end
end
