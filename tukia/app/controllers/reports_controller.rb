class ReportsController < ApplicationController
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
    @report_pages, @reports = paginate :reports, :per_page => 10
  end

  def show
    @report = Report.find(params[:id])
  end

  def new
    @report = Report.new
  end

  def create
    @report = Report.new(params[:report])
    if @report.save
      flash[:notice] = 'Report was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @report = Report.find(params[:id])
  end

  def update
    @report = Report.find(params[:id])
    #this fixes the clearing-checkbox bug, as documented in the CheckboxHABTM article on the wiki.
    if !params['report']['project_ids']
      @report.projects.clear
    end
    
    if @report.update_attributes(params[:report])
      flash[:notice] = 'Report was successfully updated.'
      redirect_to :action => 'show', :id => @report
    else
      render :action => 'edit'
    end
  end

  def destroy
    Report.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
  
  helper_method :find_all_template_actions
  # returns an array of all the available templates.
  def find_all_template_actions
    result = []
    for m in self.methods
      if (m =~ /^report_template_/)
        result << m
      end
    end
    result
  end
  
  # Reports.  It was easier to implement them as actions on the controller.
  # Doing it any other way, while it might be more elegant from some perspectives,
  # would involve introspection or some shit.
  
  
  def report_template_clause3
    @report = Report.find(params[:id])
    render :layout => "template"
  end
end
