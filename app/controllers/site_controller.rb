class SiteController < ApplicationController
  layout "standard"
  before_filter :login_required
  
  def welcome
    
  end
  
    # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }
end
