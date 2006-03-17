module Globalize
  class Language < ActiveRecord::Base
    has_and_belongs_to_many :documents
    has_many :globalize_language_names
    has_many :terms
    
    #ANDREW START HERE ANY MAKE LANGUAGE NAMES WORK (and show the i18n'd
    
    #names in the document _form, of course)
    #also, I need to evaluate the existence of these models wrapping the
    #globalize classes, as I need look up the possible existence of models
    #already implemented in Globalize
  end
end
