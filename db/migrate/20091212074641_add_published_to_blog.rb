class AddPublishedToBlog < ActiveRecord::Migration
  def self.up
    add_column :blogs, :published, :boolean
  end

  def self.down
    remove_column :blogs, :published
  end
end
