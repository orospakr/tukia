class Person < ActiveRecord::Base
  validates_presence_of :name
  validates_presence_of :givenname
  validates_presence_of :surname
  validates_presence_of :password
  validates_presence_of :email
  validates_presence_of :created
  validates_presence_of :lastlogin
end
