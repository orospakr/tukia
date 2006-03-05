class GlobalizeCountry < ActiveRecord::Base
  # this is a model around a class that is not mine.  It is part of globalize.
  has_many :term
end
