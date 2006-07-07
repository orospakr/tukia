class TermsController < ApplicationController
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
    @term_pages, @terms = paginate :terms, :per_page => 10
  end

  def show
    @term = Term.find(params[:id])
  end

  def new
    @term = Term.new
    # check to see if a synonmic group was submitted
    if (Synonmic.exists?(params[:synonmic]))
      @preselected_synonmic = Synonmic.find(params[:synonmic])
    end
    # default value for 'deleted' should be false.
    @term.deleted = false
  end

  def create
    @term = Term.new(params[:term])
    if (!((!@term.synonmic.nil?) && Synonmic.exists?(@term.synonmic.id)))
      @term.synonmic = Synonmic.new()
      @term.synonmic.save!
    end
    @term.person = @session[:user]
    if (@term.synonmic.nil?)
      warning "WTF?! synonmic is nil!"
    end
    saveresult = @term.save!
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
