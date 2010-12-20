require 'fcntl'

class Blog < ActiveRecord::Base
  has_many :blog_tags
  has_many :tags, :through => :blog_tags
  
  validate :file => :presence
  validate :url_key => :presence
  
  before_create :create_file
  
  def create_file
    unless file.blank? or File.exists? file_path
      File.open(file_path, Fcntl::O_CREAT|Fcntl::O_WRONLY) do |f|
        f.puts "<!-- A blog entry will appear here shortly -->"
      end
    end
  end
      
  
  # get full path to file
  def file_path    
    File.join(Rails.root, "blog", file)
  end
  
  # get updated_at
  def last_update
    if File.exists? self.file_path
      File.stat(self.file_path).ctime
    else 
      updated_at
    end
  end
end
