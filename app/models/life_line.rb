class LifeLine < CouchRest::Model::Base
  use_database CouchRest.database!('http://192.168.2.4:5984/life_lines')
  
  property :title, String
  property :origin, String
  property :contents, String
  property :url_key, String
  property :publish_time, Time
  
  timestamps!
  
  [ :created_at, :url_key, :title, :origin ].each { |view| view_by view }
  
  validates_uniqueness_of :url_key
  
  def html_safe?
    %w(bitly flickr twitter github).include? origin
  end
end