class SiteController < ApplicationController
  layout "standard"
  before_filter :login_required
  
  def welcome
    
  end
end
