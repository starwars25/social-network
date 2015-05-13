require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @user = User.new(username: 'example', email: 'foobar@bar.com')
  end

  test "should create user" do
    assert_difference 'User.count', 1 do
      User.create(username: 'foobar', email: 'foobar@foo.com')
    end
  end

  test "should not create user" do
    assert_no_difference 'User.count' do
      User.create(username: '', email: '')
    end
  end

  test "username must be long enough" do
    assert_no_difference 'User.count' do
      User.create(username: 'foo', email: 'foobar@foo.com')
    end
  end

  test "username must not be too long" do
    assert_no_difference 'User.count' do
      User.create(username: 'a'*21, email: 'foobar@foo.com')
    end
  end

  test "valid emails" do
    emails = %w(foo@bar.com foobar@foo.org foobar@foo.ru)
    emails.each do |email|
      user = User.new(username: 'foobar', email: email)
      assert  user.valid?
    end
  end

  test "invalid emails" do
    emails = %w(@bar.com, foobar, foo@bar)
    emails.each do |email|
      user = User.new(username: 'foobar', email: email)
      assert_not  user.valid?
    end
  end

  test "username must be unique" do
    assert_difference 'User.count', 1 do
      User.create(username: 'foobar', email: 'foobar@foo.com')
    end
    assert_no_difference 'User.count' do
      User.create(username: 'foobar', email: 'foobar@bar.com')
    end
  end

  test "email must be unique" do
    assert_difference 'User.count', 1 do
      User.create(username: 'foobar', email: 'foobar@foo.com')
    end
    assert_no_difference 'User.count' do
      User.create(username: 'foobaz', email: 'foobar@foo.com')
    end
  end

  test "downcase test" do
    assert_difference 'User.count', 1 do
      User.create(username: 'foobar', email: 'foobar@foo.com')
    end
    assert_no_difference 'User.count' do
      User.create(username: 'Foobar', email: 'foobar@bar.com')
    end
  end

  test "email downcase test" do
    assert_difference 'User.count', 1 do
      User.create(username: 'foobar', email: 'foobar@foo.com')
    end
    assert_no_difference 'User.count' do
      User.create(username: 'foobaz', email: 'Foobar@foo.com')
    end
  end

  # test "downcase test" do
  #   duplicate_user = @user.dup
  #   duplicate_user.email.upcase!
  #   @user.save
  #   assert duplicate_user.valid?
  # end
end
