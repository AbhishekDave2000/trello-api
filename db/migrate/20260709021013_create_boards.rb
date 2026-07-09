class CreateBoards < ActiveRecord::Migration[8.1]
  def change
    create_table :boards do |t|
      t.string :title,          null: false
      t.string :slug,           null: false
      t.references :workspace,  null: false, foreign_key: true
      t.references :owner,      null: false, foreign_key: { to_table: :users }
      t.string :bg_color
      t.string :bg_img
      t.integer :visibility,    null: false, default: 0
      t.datetime :archived_at

      t.timestamps
    end
  end
end
