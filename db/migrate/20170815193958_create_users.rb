class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.integer :employee
      t.integer :role
      t.integer :team

      t.timestamps
    end
  end
end
