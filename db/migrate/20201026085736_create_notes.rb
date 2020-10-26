class CreateNotes < ActiveRecord::Migration[5.2]
  def change
    create_table :notes do |t|

    	t.integer :user_id
    	t.date :date
    	t.integer :condition

      t.timestamps
    end
  end
end
