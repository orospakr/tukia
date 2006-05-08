class CommitteesController < ApplicationController
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
    @committee_pages, @committees = paginate :committees, :per_page => 10
  end

  def show
    @committee = Committee.find(params[:id])
  end

  def new
    @committee = Committee.new
    @committees = Committee.find(:all)
  end

  def create
    @committee = Committee.new(params[:committee])
    @committees = Committee.find(:all)
    saveresult = @committee.save
    if (saveresult || saveresult.nil? )
      flash[:notice] = 'Committee was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @committee = Committee.find(params[:id])
    @committees = Committee.find(:all)
  end

  def update
    @committee = Committee.find(params[:id])
    updateresult = @committee.update_attributes(params[:committee])
    if (updateresult || updateresult.nil?)
      flash[:notice] = 'Committee was successfully updated.'
      redirect_to :action => 'show', :id => @committee
    else
      render :action => 'edit'
    end
  end

  def destroy
    Committee.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
