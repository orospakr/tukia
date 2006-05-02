class Usage < ActiveRecord::Base
  belongs_to :document
  belongs_to :term
end
