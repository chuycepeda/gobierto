require "test_helper"

module GobiertoPeople
  class PersonDecoratorTest < ActiveSupport::TestCase
    def setup
      super
      @subject = PersonDecorator.new(person)
    end

    def person
      @person ||= gobierto_people_people(:richard)
    end

    def test_contact_email
      assert_nil @subject.contact_email
    end

    def test_twitter_handle
      assert_equal "@richard", @subject.twitter_handle
    end

    def test_twitter_url
      assert_equal "https://twitter.com/richard", @subject.twitter_url
    end

    def test_facebook_handle
      assert_nil @subject.facebook_handle
    end

    def test_facebook_url
      assert_nil @subject.facebook_url
    end

    def test_linkedin_handle
      assert_nil @subject.linkedin_handle
    end

    def test_linkedin_url
      assert_nil @subject.linkedin_url
    end
  end
end
