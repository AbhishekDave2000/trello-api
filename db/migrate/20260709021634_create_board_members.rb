class CreateBoardMembers < ActiveRecord::Migration[8.1]
  def change
    create_table :board_members do |t|
      t.references :board,  null: false, foreign_key: true
      t.references :user,   null: false, foreign_key: true
      t.integer :role,      null: false, default: 0

      t.timestamps
    end
  end
end
