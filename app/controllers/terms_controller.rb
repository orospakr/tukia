class TermsController < ApplicationController
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
  end

  def create
    @term = Term.new(params[:term])
    if @term.save
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
    if @term.update_attributes(params[:term])
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
