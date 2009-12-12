require 'test_helper'

class NotificationsTest < ActionMailer::TestCase
  test "new_comment" do
    @expected.subject = 'Notifications#new_comment'
    @expected.body    = read_fixture('new_comment')
    @expected.date    = Time.now

    assert_equal @expected.encoded, Notifications.create_new_comment(@expected.date).encoded
  end

end
