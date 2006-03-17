#here I extend the globalizecountry model provided by the globalilze plugin.
#damn I <3 ruby.

module Globalize
  class Country < ActiveRecord::Base
    has_many :terms
  end
end
