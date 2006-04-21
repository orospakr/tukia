class TermsController < ApplicationController
  layout "standard"
  
  def index
    list
    render :action => 'list'
  end

  def list
    @term_pages, @terms = paginate :terms, :per_page => 10
  end

  def show
    @term = Term.find(params[:id])
  end

  def new
    @term = Term.new
    @term.deleted = false
  end

  def create
    @term = Term.new(params[:term])
    # TODO SET @term.person = to THE LOGGED IN PERSION
    saveresult = @term.save
    if (saveresult || saveresult.nil?)
      flash[:notice] = 'Term was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @term = Term.find(params[:id])
  end

  def update
    @term = Term.find(params[:id])
    updateresult = @term.update_attributes(params[:term])
    if (updateresult || updateresult.nil?)
      flash[:notice] = 'Term was successfully updated.'
      redirect_to :action => 'show', :id => @term
    else
      render :action => 'edit'
    end
  end

  def destroy
    Term.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
