require File.dirname(__FILE__) + '/../test_helper'

class GlobalizeLanguagesTest < Test::Unit::TestCase
  fixtures :globalize_languages

  # Replace this with your real tests.
  def test_truth
    assert_kind_of GlobalizeLanguages, globalize_languages(:first)
  end
end
