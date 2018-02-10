class AddColumnToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :instags, :user_id, :integer
  end
end
