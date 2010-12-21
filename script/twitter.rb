#!script/rails runner

require 'twitter'

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