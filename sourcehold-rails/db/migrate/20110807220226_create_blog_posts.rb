class CreateBlogPosts < ActiveRecord::Migration
  def self.up
    create_table :blog_posts do |t|
      t.string :title
      t.text :body
      t.boolean :published
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :blog_posts
  end
end
