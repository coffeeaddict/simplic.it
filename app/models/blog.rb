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
        f.puts "<!-- title: -->"
        f.puts "<!-- subtitle: -->"
        f.puts "<!-- tags: -->"
        f.puts "\nA blog entry will appear here shortly\n"
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

  def self.create_from_file file, url_key=nil
    blog = create( :file => file, :url_key => url_key )

    contents = File.read blog.file_path
    if ( match = contents.match(/<!-- title: (.*)-->/) )
      blog.title = match[1].gsub(/\s+$/, '') if !match[1].nil?
    end
    if ( match = contents.match(/<!-- subtitle: (.*)-->/) )
      blog.subtitle = match[1].gsub(/\s+$/, '') if !match[1].nil?
    end
    if ( match = contents.match(/<!-- tags: (.*)-->/) )
      if ( tags = match[1] )
        tags.gsub!(/\s+$/, '')
        tags = tags.split /,\s*/
        tags.each do |name|
          tag = Tag.find_or_create_by_name(name)
          blog.tags << tag
        end
      end
    end

    if url_key.nil?
      url_key = blog.title.downcase.gsub(/[^[:alnum:]:!-#\[\]]/u, "-").sub(/-+$/, '')

      if Blog.exists?( :url_key => url_key )
        url_key += "-1"
      end

      while Blog.exists?( :url_key => url_key )
        url_key.succ!
      end

      blog.url_key = url_key
    end

    blog.save

    return blog
  end
end
