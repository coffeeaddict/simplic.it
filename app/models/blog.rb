class Blog < ActiveRecord::Base
  has_and_belongs_to_many :tags
  has_many :comments
  belongs_to :user

  def has_next?
    count = Blog.count(
      :conditions => [ "published = 't' and created_at > ?", self.created_at ]
    )
    return ( count > 0 ? 't' : false )
  end

  def next
    Blog.find( :first, 
               :conditions => [ "published = 't' and created_at > ?", self.created_at ],
               :order => "created_at ASC"
             )
  end

  def has_prev?
    count = Blog.count(
      :conditions => [ "published = 't' and created_at < ?", self.created_at ]
    )
    return ( count > 0 ? 't' : false )
  end

  def prev
    Blog.find( :first, 
               :conditions => [ "published = 't' and created_at < ?", self.created_at ],
               :order => "created_at DESC"
             )
  end

  def self.find_by_title title
    first( :conditions => [ "title like ?", title ] )
  end

  def x_attributes
    x = attributes.dup.delete_if { |k,v|
     !%w(title subtitle created_at updated_at).include? k
    }
    x['created_at'] = x['created_at'].to_s
    x['updated_at'] = x['updated_at'].to_s

    x.merge( { 'url_key' => x['title'].downcase.gsub(" ", "-"), 'file' => x['title'].downcase.gsub(" ", "_") } )
  end
end
