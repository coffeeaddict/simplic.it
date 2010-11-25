class Page < CouchRest::Model::Base
  use_database CouchRest.database!('http://192.168.2.4:5984/pages') 

  property :title, String
  property :contents, String
  property :path, String
  property :info, String

  timestamps!
  
  view_by :path
end
