class CreateRealtimes < ActiveRecord::Migration
  def change
    create_table :realtimes do |t|
      t.string "Title"
      t.text "Content"
      t.timestamps null: false
    end
  end
end
