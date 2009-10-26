class AddClicksToBounce < ActiveRecord::Migration
  def self.up
    add_column :bounces, :clicks, :integer
  end

  def self.down
    remove_column :bounces, :clicks
  end
end
