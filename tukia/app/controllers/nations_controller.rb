class NationsController < ApplicationController
  layout "standard"
  before_filter :login_required
  
  def index
    list
    render :action => 'list'
  end
  
    # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @nation_pages, @nations = paginate :nations, :per_page => 10
  end

  def show
    @nation = Nation.find(params[:id])
  end

  def new
    @nation = Nation.new
  end

  def create
    @nation = Nation.new(params[:nation])
    saveresult = @nation.save
    if (saveresult || saveresult.nil?)
      flash[:notice] = 'Nation was successfully created.'
      redirect_to :action => 'list'
    else
      
      render :action => 'new'
    end
  end
  
  def testcaselol
    Nation.testcaselol
    render :action => 'new'
  end

  def edit
    @nation = Nation.find(params[:id])
  end

  def update
    @nation = Nation.find(params[:id])
    #this fixes the clearing-checkbox bug, as documented in the CheckboxHABTM article on the wiki.
    if !params['nation']['person_ids']
      @nation.people.clear
    end
    
    updateresult = @nation.update_attributes(params[:nation])
    if (updateresult || updateresult.nil?)
      flash[:notice] = 'Nation was successfully updated.'
      redirect_to :action => 'show', :id => @nation
    else
      render :action => 'edit'
    end
  end

  def destroy
    Nation.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
