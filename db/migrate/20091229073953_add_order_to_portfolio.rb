class AddOrderToPortfolio < ActiveRecord::Migration
  def self.up
    add_column :portfolios, :order, :integer
  end

  def self.down
    remove_column :portfolios, :order
  end
end
