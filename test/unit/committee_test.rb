require File.dirname(__FILE__) + '/../test_helper'

class CommitteeTest < Test::Unit::TestCase
  fixtures :committees

  # Replace this with your real tests.
  def test_truth
    assert_kind_of Committee, committees(:isoiec)
  end
end
