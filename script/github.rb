#!script/rails runner

require 'feed_me'
require 'open-uri'

feed = FeedMe.parse open('https://github.com/coffeeaddict.atom')

feed.entries.each do |item|  
  LifeLine.create(
    :contents     => item.content,
    :origin       => "github",
    :publish_time => item.updated_at.in_time_zone("Amsterdam"),
    :url_key      => item.item_id
  )
end
