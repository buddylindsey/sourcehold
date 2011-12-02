class CreateAuthorizedKeys < ActiveRecord::Migration
  def self.up
    create_table :authorized_keys do |t|
      t.integer :user_id
      t.text :key
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :authorized_keys
  end
end
