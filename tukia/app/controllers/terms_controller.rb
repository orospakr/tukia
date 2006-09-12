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
    @term_pages, @terms = paginate :terms, :per_page => 300, :order => "term"
  end

  def show
    @term = Term.find(params[:id])
  end

  def new
    @term = Term.new
    # detect if this is a new fork
    if (Term.exists?(params[:parent]))
      # set all fields on new term to the parent, and set parent_id to the parent
      parent = Term.find(params[:parent])
      @term.setup_from_parent(parent)
    else
      # do the normal stuff for a new term.
      # check to see if a synonmic group was submitted
      if (Synonmic.exists?(params[:synonmic]))
        @term.synonmic = Synonmic.find(params[:synonmic])
      end
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
    #this fixes the clearing-checkbox bug, as documented in the CheckboxHABTM article on the wiki.
    if !params['term']['project_ids']
      @term.projects.clear
    end
    
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
