#!script/rails runner

require 'feed_me'
require 'open-uri'
require 'twitter'

bitly = FeedMe.parse open('http://bit.ly/u/coffeeaddict.rss')
bitly.entries.each do |item|  
  LifeLine.create(
    :contents     => item.content,
    :origin       => "bitly",
    :publish_time => item.updated_at.in_time_zone("Amsterdam"),
    :url_key      => item.item_id
  )
end

github = FeedMe.parse open('https://github.com/coffeeaddict.atom')
github.entries.each do |item|  
  LifeLine.create(
    :contents     => "<h4>#{item.title}</h4>#{item.content}",
    :origin       => "github",
    :publish_time => item.updated_at.in_time_zone("Amsterdam"),
    :url_key      => item.item_id
  )
end

Twitter.user_timeline("coffeeaddict_nl").each do |tweet|
  contents   = tweet.text
  created_at = Time.parse(tweet.created_at).in_time_zone(tweet.time_zone)
  LifeLine.create(
    :contents     => contents,
    :origin       => "twitter",
    :publish_time => created_at,
    :url_key      => tweet.id_str
  )
end

# mentions on twitter
Twitter::Search.new.q("@coffeeaddict_nl").fetch.each do |mention|
  contents = mention.text
  created_at = Time.parse(mention.created_at).in_time_zone(mention.time_zone)
  LifeLine.create(
    :contents     => contents,
    :origin       => "twitter",
    :publish_time => created_at,
    :url_key      => mention.id_str
  )
end

flickr = FeedMe.parse open(
  'http://api.flickr.com/services/feeds/photos_public.gne?'+
  'id=34415711@N02&amp;lang=en-us&amp;format=atom'
)
flickr.entries.each do |item|  
  LifeLine.create(
    :contents     => item.enclosure,
    :origin       => "flickr",
    :publish_time => item.updated_at.in_time_zone("Amsterdam"),
    :url_key      => item.item_id
  )
end
