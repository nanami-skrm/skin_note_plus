class CreateMyItems < ActiveRecord::Migration[5.2]
  def change
    create_table :my_items do |t|

    	t.integer :user_id
    	t.string :item_name
    	t.string :maker

      t.timestamps
    end
  end
end
