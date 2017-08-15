class AddCertLevel < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :certLevel, :integer
  end
end
