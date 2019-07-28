class CreateInformation < ActiveRecord::Migration
  def change
    create_table :information do |t|

      t.string :title
      t.text :menu
      t.text:location
      t.integer :x_loc
      t.integer :y_loc
      t.integer :date
      t.string :day
      t.integer:like

      t.timestamps null: false
    end
  end
end
