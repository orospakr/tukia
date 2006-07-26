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
  
  helper_method :prepare_boldify_regex
  def prepare_boldify_regex(terms_to_bold_from)
    return "" if (terms_to_bold_from.size <= 0)
    bigfuckingregex = ""
    terms_to_bold = terms_to_bold_from.sort do |a,b|
      a.term.length <=> b.term.length
    end
    for t in terms_to_bold
        bigfuckingregex += "(\\b" + Regexp.escape(t.term) + "(|s|es)\\b)|" if (t.term.length > 1)  
    end
    bigfuckingregex = bigfuckingregex.chop
    return Regexp.compile(bigfuckingregex)
  end
  
  helper_method :boldify
  def boldify(target_definition, terms_regex)
    # make a huge fucking ass regexp and apply it to DefinitionToBold.
    # why not lots of little regexps, you say? WELL, isn't that a funny thing!
    # you see, if I have lots of little ones, small terms that turn out to be substrings
    # of others will get double-bolded, potentially. stupid, huh?
    # I hate the world of text processing.
    notes_example_start = 0
    example_pos = target_definition.index("EXAMPLE")
    note_pos = target_definition.index("NOTE")
    exemple_pos = target_definition.index("EXEMPLE")
    notes_example_start = example_pos if ((!example_pos.nil?) && (example_pos < notes_example_start || notes_example_start == 0))
    notes_example_start = note_pos if ((!note_pos.nil?) && (note_pos < notes_example_start || notes_example_start == 0))
    notes_example_start = exemple_pos if ((!exemple_pos.nil?) && (exemple_pos < notes_example_start || notes_example_start == 0))
    if (notes_example_start > 0)
      to_bold = target_definition.Substring(0, notes_example_start)
      not_to_bold = target_definition.Substring(notes_example_start, target_definition.Length - notes_example_start)
    else
      to_bold = target_definition
      not_to_bold = ""
    end
    return to_bold.gsub(terms_regex,  "<b>$0</b>") + not_to_bold
  end
  
  # Reports.  It was easier to implement them as actions on the controller.
  # Doing it any other way, while it might be more elegant from some perspectives,
  # would involve introspection or some shit.
  
  def report_template_clause3
    @report = Report.find(params[:id])
    render :layout => "template"
  end
end
