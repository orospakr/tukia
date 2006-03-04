require File.dirname(__FILE__) + '/../test_helper'

class GlobalizeLanguageNamesTest < Test::Unit::TestCase
  fixtures :globalize_language_names

  # Replace this with your real tests.
  def test_truth
    assert_kind_of GlobalizeLanguageNames, globalize_language_names(:first)
  end
end
