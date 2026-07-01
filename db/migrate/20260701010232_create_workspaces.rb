class CreateWorkspaces < ActiveRecord::Migration[8.1]
  def change
    create_table :workspaces do |t|
      t.string :name,         null: false
      t.string :slug
      t.text :description
      t.boolean :visibility,  null: false, default: true
      t.references :owner,    null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
