class RepositoryAddSizeColumn < ActiveRecord::Migration
  def self.up
    add_column :repositories, :size, :string
  end

  def self.down
    remove_column :repositories, :size
  end
end
