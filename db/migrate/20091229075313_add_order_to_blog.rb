class AddOrderToBlog < ActiveRecord::Migration
  def self.up
    add_column :blogs, :order, :integer
  end

  def self.down
    remove_column :blogs, :order
  end
end
