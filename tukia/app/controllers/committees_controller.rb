class CommitteesController < ApplicationController
  def index
    list
    render :action => 'list'
  end

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
    if @committee.save
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
    if @committee.update_attributes(params[:committee])
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
