class Blog < ActiveRecord::Base
  has_many :blog_tags
  has_many :tags, :through => :blog_tags
  
  # get full path to file
  def file    
    File.join(Rails.root, "public", "blog", super)
  end
  
  # get updated_at
  def updated_at
    if File.exists? self.file
      File.stat(self.file).ctime
    else 
      super
    end
  end
end
