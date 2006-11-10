module Globalize
  class Language < ActiveRecord::Base
    has_and_belongs_to_many :documents
    has_many :language_names
    has_many :terms
    
    def full_english_name
      begin
        self_english_name + " " + english_name_modifier
      rescue
        self_english_name
      end
    end
    
    def get_name_from_code
      if (self.iso_639_3.nil?)
        return
      end
      return ("ISO 639-3: " + self.iso_639_3).t(self.english_name)
    end
    
    # gets from ISO 639-2 Alpha 3 code. helps with brevity in the report templates
    def get_from_code(codelol)
      Globalize::Language.find(:first, :conditions => ["iso_639_3 = ?", codelol])
    end
  end
end
