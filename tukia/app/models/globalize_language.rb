module Globalize
  class Language < ActiveRecord::Base
    has_and_belongs_to_many :documents
    has_many :language_names
    has_many :terms
    
    
    def get_name_current_culture(user)
      if (user.nil?)
        return @english_name
      else
        result = LanguageName.find(:first,
                                   :conditions => ["name_language_id = ? AND language_id = ?", user.language, @id])
        if (result.nil?)
          return @english_name
        else
          return result.name
        end
      end
    end
    
  end
end
