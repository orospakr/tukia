module Globalize
  class LanguageName < ActiveRecord::Base
    set_table_name "globalize_language_names"
    has_many :languages, :class_name => "Language"
    has_many :name_languages, :foreign_key => "name_language_id", :class_name => "Language"
  end
end
