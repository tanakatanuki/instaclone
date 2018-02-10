class CreateInsta < ActiveRecord::Migration[5.1]
  def change
    create_table :insta do |t|

      t.timestamps
    end
  end
end
