require_dependency "#{RAILS_ROOT}/vendor/plugins/globalize/lib/globalize/models/country.rb"

module Globalize
  class Country < ActiveRecord::Base
    has_many :terms
  end
end
