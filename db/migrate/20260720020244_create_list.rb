class CreateList < ActiveRecord::Migration[8.1]
  def change
    create_table :lists do |t|
      t.string :title,          null: false
      t.references :board,      null: false, foreign_key: true
      t.float :position,      null: false
      t.datetime :archived_at

      t.timestamps
    end
  end
end
