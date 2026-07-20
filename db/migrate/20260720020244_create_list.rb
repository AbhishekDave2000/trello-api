class CreateList < ActiveRecord::Migration[8.1]
  def change
    create_table :lists do |t|
      t.string :title,          null: false
      t.references :board,      null: false, foreign_key: true
      t.float :position,      null: false
      t.datetime :archived_at

      t.timestamps
    end

    add_index :lists, [:board_id, :position]
  end
end
