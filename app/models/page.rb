class Page < CouchRest::Model::Base
  use_database CouchRest.database!('http://127.0.0.1:5984/pages') 

  property :title, String
  property :contents, String
  property :created_at, Time
  property :updated_at, Time
end
