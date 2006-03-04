require File.dirname(__FILE__) + '/../test_helper'

class TermTest < Test::Unit::TestCase
  fixtures :terms

  # Replace this with your real tests.
  def test_truth
    assert_kind_of Term, terms(:first)
  end
end
