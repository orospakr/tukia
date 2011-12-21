class Status < ActiveRecord::Base
  has_many :projects, :dependent => :destroy
  validates_presence_of :name
end
