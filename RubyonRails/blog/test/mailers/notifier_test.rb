require 'test_helper'

class NotifierTest < ActionMailer::TestCase
  test "email_friend" do
  	article = articles(:welcome_to_rails)
  	message = Notifier.email_friend(article, 'John Smith', 'dude@example.com')

    mail = Notifier.email_friend
    assert_equal "interesting Article", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
