class CreateCorrectives < ActiveRecord::Migration[5.1]
  def change
    create_table :correctives do |t|
      t.string :description
      t.date :date
      t.string :supervisor
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
