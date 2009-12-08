class TagSystem < ActiveRecord::Migration
  def self.up
    create_table :blogs_tags do |t|
      t.integer :blog_id
      t.integer :tag_id
      t.timestamps
    end
  end

  def self.down
    drop_table :blogs_tags
  end
end
