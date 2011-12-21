class Usage < ActiveRecord::Base
  belongs_to :project
  belongs_to :term
end
