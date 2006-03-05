require File.dirname(__FILE__) + '/../test_helper'

class GlobalizeCountryTest < Test::Unit::TestCase
  fixtures :globalize_countries

  # Replace this with your real tests.
  def test_truth
    assert_kind_of GlobalizeCountry, globalize_countries(:first)
  end
end
