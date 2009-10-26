class CreateBounces < ActiveRecord::Migration
  def self.up
    create_table :bounces do |t|
      t.string :url

      t.timestamps
    end
  end

  def self.down
    drop_table :bounces
  end
end
