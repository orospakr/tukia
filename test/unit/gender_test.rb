require File.dirname(__FILE__) + '/../test_helper'

class GenderTest < Test::Unit::TestCase
  fixtures :genders

  # Replace this with your real tests.
  def test_truth
    assert_kind_of Gender, genders(:first)
  end
end
