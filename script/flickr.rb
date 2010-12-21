#!script/rails runner

require 'feed_me'
require 'open-uri'

feed = FeedMe.parse open(
  'http://api.flickr.com/services/feeds/photos_public.gne?'+
  'id=34415711@N02&amp;lang=en-us&amp;format=atom'
)

feed.entries.each do |item|  
  LifeLine.create(
    :contents     => item.enclosure,
    :origin       => "flickr",
    :publish_time => item.updated_at.in_time_zone("Amsterdam"),
    :url_key      => item.item_id
  )
end
