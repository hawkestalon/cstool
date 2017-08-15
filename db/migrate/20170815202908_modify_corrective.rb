class ModifyCorrective < ActiveRecord::Migration[5.1]
  def change
    remove_column :correctives, :date
    add_column :correctives, :date_of, :date
    add_column :correctives, :supsig, :string
    add_column :correctives, :agentsig, :string
    add_column :correctives, :mansig, :string
    add_column :correctives, :typeOf, :string
    add_column :correctives, :plan, :string
    add_column :correctives, :action, :string
    add_column :correctives, :comments, :string
  end
end
