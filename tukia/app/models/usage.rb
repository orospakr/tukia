class Usage < ActiveRecord::Base
  belongs_to :projects
  belongs_to :term
end
