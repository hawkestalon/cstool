class CreateCoaches < ActiveRecord::Migration[5.1]
  def change
    create_table :coaches do |t|
      t.string :details
      t.string :goals
      t.string :reminder

      t.timestamps
    end
  end
end
