class AddPublishedToPortfolio < ActiveRecord::Migration
  def self.up
    add_column :portfolios, :published, :boolean
  end

  def self.down
    remove_column :portfolios, :published
  end
end
