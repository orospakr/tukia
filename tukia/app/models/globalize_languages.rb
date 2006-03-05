class GlobalizeLanguages < ActiveRecord::Base
  has_many: document
  has_many: globalize_language
  has_many: term
end
