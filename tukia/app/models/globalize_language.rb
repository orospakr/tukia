module Globalize
  class Language < ActiveRecord::Base
    has_and_belongs_to_many :documents
    has_many :language_names
    has_many :terms
    
    def get_name_from_code
      if (self.iso_639_3.nil?)
        return
      end
      return ("ISO 639-3: " + self.iso_639_3).t(self.english_name)
    end
    
    def get_from_code(codelol)
      #Globalize::Language.find(:first, :conditions => ["iso_639_3 = ?", codelol])
    end
    

  end
end
