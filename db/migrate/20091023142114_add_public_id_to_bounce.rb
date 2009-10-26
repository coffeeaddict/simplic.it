class AddPublicIdToBounce < ActiveRecord::Migration
  def self.up
    add_column :bounces, :public_id, :string
  end

  def self.down
    remove_column :bounces, :public_id
  end
end
