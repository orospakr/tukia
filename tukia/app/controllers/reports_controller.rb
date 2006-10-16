require "pcre"

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
    bigfuckingregex = "("
    terms_to_bold = terms_to_bold_from.sort do |a,b|
      a.term.length <=> b.term.length
    end
    for t in terms_to_bold
      bigfuckingregex += "(\\b" + Regexp.escape(t.term) + "(|s|es)\\b)|" if (t.term.length > 1)  
    end
    bigfuckingregex = bigfuckingregex.chop + ")"
    #bigfuckingregex = "((\\bset(|s|es)\\b)|(\\bdata(|s|es)\\b)|(\\bterm(|s|es)\\b))";
    bigfuckingregex = "((\\battribute(|s|es)\\b)|(\\bdata(|s|es)\\b))"
    return Regexp.compile(bigfuckingregex)
    printf "\nBFR: " + bigfuckingregex + "\n";
    return bigfuckingregex;
  end
  
  helper_method :boldify
  def boldify(target_definition, terms_to_bold_from, target_term)
    # make a huge fucking ass regexp and apply it to DefinitionToBold.
    # why not lots of little regexps, you say? WELL, isn't that a funny thing!
    # you see, if I have lots of little ones, small terms that turn out to be substrings
    # of others will get double-bolded, potentially. stupid, huh?
    # I hate the world of text processing.
    return target_definition if (terms_to_bold_from.size <= 0) # in case there are no terms available
    notes_example_start = 0
    example_pos = target_definition.index("EXAMPLE")
    note_pos = target_definition.index("NOTE")
    exemple_pos = target_definition.index("EXEMPLE")
    notes_example_start = example_pos if ((!example_pos.nil?) && (example_pos < notes_example_start || notes_example_start == 0))
    notes_example_start = note_pos if ((!note_pos.nil?) && (note_pos < notes_example_start || notes_example_start == 0))
    notes_example_start = exemple_pos if ((!exemple_pos.nil?) && (exemple_pos < notes_example_start || notes_example_start == 0))
    if (notes_example_start > 0)
      to_bold = target_definition[0, notes_example_start]
      not_to_bold = target_definition[notes_example_start, target_definition.length - notes_example_start]
    else
      to_bold = target_definition
      not_to_bold = ""
    end
    # loop through the terms, from longest to shortest.
    #terms_to_bold_from.delete(target_term)
    terms_to_bold = terms_to_bold_from.sort do |a,b|
      begin
        b.term.length <=> a.term.length
      rescue
        -1
      end
    end
    for t in terms_to_bold
      # shitcock
      if !(t.term.nil? || t.term.length < 1) 
        termregex = Regexp.compile("(\\b" + Regexp.escape(t.term) + "(|s|es)\\b)")
        to_bold = to_bold.gsub(termregex, "<b>\\0</b>")
      end
    end
    # now do it again, but with the acronyms
    acronyms_to_bold = terms_to_bold_from.sort do |a,b|
      begin
        b.acronym.length <=> a.acronym.length
      rescue
        -1
      end
    end
    for a in acronyms_to_bold
      if !(a.acronym.nil? || a.acronym.length < 1) 
        acronymregex = Regexp.compile("(\\b" + Regexp.escape(a.acronym) + "(|s|es)\\b)")
        to_bold = to_bold.gsub(acronymregex, "<b>\\0</b>")
      end
    end
    return to_bold + not_to_bold
  end
  
  # Reports.  It was easier to implement them as actions on the controller.
  # Doing it any other way, while it might be more elegant from some perspectives,
  # would involve introspection or some shit.
  
  def report_template_clause3
    @report = Report.find(params[:id])
    render :layout => "template"
  end
  
  def report_template_clause4
    @report = Report.find(params[:id])
    render :layout => "template"
  end
  
  def report_template_annex_a_vsecfrench
    @report = Report.find(params[:id])
    render :layout => "template"
  end
  
  def report_template_annex_a_4
    @report = Report.find(params[:id])
    render :layout => "template"
  end
  
  def report_template_annex_a_6
    @report = Report.find(params[:id])
    render :layout => "template"
  end
  
  def mega_report
    #@report = Report.find(params[:id])
    render :layout => "template"
  end
end
