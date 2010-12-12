class CreateBlogs < ActiveRecord::Migration
  def self.up
    create_table :blogs do |t|
      t.string :url_key
      t.string :file
      t.string :title
      t.string :subtitle
      
      t.timestamps
    end
  end

  def self.down
    drop_table :blogs
  end
end
