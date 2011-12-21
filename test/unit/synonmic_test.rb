require File.dirname(__FILE__) + '/../test_helper'

class SynonmicTest < Test::Unit::TestCase
  fixtures :synonmics

  # Replace this with your real tests.
  def test_truth
    assert_kind_of Synonmic, synonmics(:first)
  end
end
