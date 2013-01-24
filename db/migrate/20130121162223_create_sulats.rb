class CreateSulats < ActiveRecord::Migration
  def change
    create_table :sulats do |t|
      t.string :subject
      t.text :msgbody
      t.boolean :read, :default => false 
      t.integer :sender_id
      t.integer :recipient_id

      t.timestamps
    end
  end
end
