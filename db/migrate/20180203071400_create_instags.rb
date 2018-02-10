class CreateInstags < ActiveRecord::Migration[5.1]
  def change
    create_table :instags do |t|
      t.text :content
      t.text :image

      t.timestamps
    end
  end
end
