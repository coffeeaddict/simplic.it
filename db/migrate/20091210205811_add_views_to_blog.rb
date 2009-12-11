class AddViewsToBlog < ActiveRecord::Migration
  def self.up
    add_column :blogs, :views, :integer
  end

  def self.down
    remove_column :blogs, :views
  end
end
