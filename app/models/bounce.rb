require 'digest.rb'

class Bounce < ActiveRecord::Base

  before_save :generate_public_id

  validates_presence_of :url
  validates_uniqueness_of :url

  def generate_public_id
    return unless self.public_id.nil? or self.public_id.empty?

    long_digest = Digest::SHA512.hexdigest(self.url)
    
    # pick 6 random bits from the sha
    id = ""
    (0..6).each do |i|
      id << long_digest[rand(long_digest.length)]
    end

    self.public_id = id
  end
end
