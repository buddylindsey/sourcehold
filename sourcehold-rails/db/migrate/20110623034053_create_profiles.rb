class CreateProfiles < ActiveRecord::Migration
  def self.up
    create_table :profiles do |t|
      t.integer :user_id
      t.string :fullname
      t.string :company
      t.string :website
      t.string :location
      t.string :alternate_contact

      t.timestamps
    end
  end

  def self.down
    drop_table :profiles
  end
end
