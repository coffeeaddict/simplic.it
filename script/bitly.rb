#!script/rails runner

require 'feed_me'
require 'open-uri'

feed = FeedMe.parse open('http://bit.ly/u/coffeeaddict.rss')

feed.entries.each do |item|  
  LifeLine.create(
    :contents     => item.content,
    :origin       => "bitly",
    :publish_time => item.updated_at.in_time_zone("Amsterdam"),
    :url_key      => item.item_id
  )
end
