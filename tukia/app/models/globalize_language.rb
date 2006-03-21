module Globalize
  class Language < ActiveRecord::Base
    has_and_belongs_to_many :documents
    has_many :language_names
    has_many :terms
    
    def self.get_name_from_code(iso_639_3, english_name)
      return ("ISO 639-3: " + iso_639_3).t(english_name)
    end
  end
end
