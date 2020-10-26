class CreateTodaysItems < ActiveRecord::Migration[5.2]
  def change
    create_table :todays_items do |t|

		t.integer :note_id
    	t.integer :my_item_id

      t.timestamps
    end
  end
end

