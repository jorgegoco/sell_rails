require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  def setup
    @user = User.last
  end

  test 'welcome' do
    mail = UserMailer.with(user: @user).welcome
    assert_equal 'Welcome to Sell It', mail.subject
    assert_equal [@user.email], mail.to
    assert_equal ['no-reply@sellit.com'], mail.from
    assert_match @user.username, mail.body.encoded
  end

end
