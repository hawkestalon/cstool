class CorrelateUsersWithCoaching < ActiveRecord::Migration[5.1]
  def change
    add_column :coaches, :user_id, :int
  end
end
