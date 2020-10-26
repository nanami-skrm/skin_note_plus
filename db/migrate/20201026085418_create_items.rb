class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|

    	t.string :item_name
    	t.integer :item_genre
    	t.string :maker
      t.timestamps
    end
  end
end
