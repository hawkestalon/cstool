class CreateAttrecords < ActiveRecord::Migration[5.1]
  def change
    create_table :attrecords do |t|
      t.integer :PTO
      t.integer :FMLA
      t.integer :days
      t.date :flexone
      t.date :flextwo
      t.date :flexthree
      t.references :user, foreign_key: true
      
      t.timestamps
    end
  end
end
