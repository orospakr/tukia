require File.dirname(__FILE__) + '/../test_helper'

class NationTest < Test::Unit::TestCase
  fixtures :nations

  # Replace this with your real tests.
  def test_truth
    assert_kind_of Nation, nations(:canada)
  end
end
