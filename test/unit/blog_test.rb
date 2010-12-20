require 'test_helper'

class BlogTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "file path" do
    b = Blog.create( :file => "foo", :url_key => "foo" )
    assert b.file_path == File.join(Rails.root, "blog", "foo"),
    "file path is right"
    
    assert File.exists?(b.file_path), "the file was created"
  end  
end
