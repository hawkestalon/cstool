class CreateMisses < ActiveRecord::Migration[5.1]
  def change
    create_table :misses do |t|
      t.string :reason
      t.datetime :a_date
      t.integer :hours
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
