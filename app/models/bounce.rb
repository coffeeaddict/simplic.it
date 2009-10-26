require 'digest.rb'

class Bounce < ActiveRecord::Base

  before_save :generate_public_id

  validates_presence_of :url, :public_id

  def generate_public_id
    exists = Bounce.find( :first, :conditions => [ "url=?", self.url ] )
    if exists
      self.errors.add( :url,
		       ( "there is already such an url defined. "+
			 "Use #{exists.public_id} to get bouncing"
                       )
                     )
      return false
    end

    long_digest = Digest::SHA512.hexdigest(self.url)
    
    # pick 6 random bits from the sha
    id = ""
    (0..6).each do |i|
      id << long_digest[rand long_digest.length]
    end

    self.public_id = id
  end
end
