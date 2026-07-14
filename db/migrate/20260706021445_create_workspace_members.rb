class CreateWorkspaceMembers < ActiveRecord::Migration[8.1]
  def change
    create_table :workspace_members do |t|
      t.references :workspace,  null: false, foreign_key: true
      t.references :user,      null: false, foreign_key: true
      t.integer :role,         null: false, default: 0

      t.timestamps
    end

    add_index :workspace_members, [ :workspace_id, :user_id ], unique: true
  end
end
