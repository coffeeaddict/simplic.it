class Blog < ActiveRecord::Base
  has_and_belongs_to_many :tags
  has_many :comments
  belongs_to :user

  def has_next?
    count = Blog.count(
      :conditions => [ "created_at > ?", self.created_at ]
    )
    return ( count > 0 ? true : false )
  end

  def next
    Blog.find( :first, 
               :conditions => [ "created_at > ?", self.created_at ],
               :order => "created_at ASC"
             )
  end

  def has_prev?
    count = Blog.count(
      :conditions => [ "created_at < ?", self.created_at ]
    )
    return ( count > 0 ? true : false )
  end

  def prev
    Blog.find( :first, 
               :conditions => [ "created_at < ?", self.created_at ],
               :order => "created_at DESC"
             )
  end
end
