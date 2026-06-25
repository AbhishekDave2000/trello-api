class CreateUsers < ActiveRecord::Migration[8.1]
  def change
    create_enum :user_role, ["member", "admin", "guest"] 

    create_table :users do |t|
      t.string :name,               null: false
      t.string :email,              null: false
      t.string :password_digest,    null: false
      t.string :avatar_url
      t.string :role,               enum_type: :user_role, default: "member", null: false    
      t.string :user_name,          null: false
      t.string :bio
      t.boolean :email_verified,    default: false
      t.datetime :email_verified_at
      t.datetime :last_seen_at
      t.string :time_zone,          default: "UTC"
      t.boolean :active,            default: true

      t.timestamps
    end
    add_index :users, :email,    unique: true
    add_index :users, :user_name, unique: true
    add_index :users, :role

  end
end
