class Tag < ActiveRecord::Base
  has_many :blog_tags
  has_many :blogs, :through => :blog_tags

  # The score of a tag; defined by it's usage
  #
  # The score is an integer between 0 and 10, and defined by the
  # percentile / 10, rounded upwards
  #
  # When there are not enough tags, the score is always 2
  #
  def score
    total   = Blog.count
    
    # return 2 if total < 20
    
    me      = BlogTag.where( :tag_id => self.id ).count
    percent = total / 100.0
    
    ((me / percent) / 10).to_i
  end
end
