class DocumentsController < ApplicationController
  layout "standard"
  before_filter :login_required
  
  def index
    list
    render :action => 'list'
  end

  def list
    @document_pages, @documents = paginate :documents, :per_page => 10
  end

  def show
    @document = Document.find(params[:id])
  end

  def new
    @document = Document.new
    # TODO I should autoset the register_number value here if I can.
    # although, the only way I can do that is 
  end

  def create
    @document = Document.new(params[:document])
    saveresult = @document.save
    if (saveresult || saveresult.nil?)
      flash[:notice] = 'Document was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @document = Document.find(params[:id])
  end

  def update
    @document = Document.find(params[:id])
    updateresult = @document.update_attributes(params[:document])
    if (updateresult || updateresult.nil?)
      flash[:notice] = 'Document was successfully updated.'
      redirect_to :action => 'show', :id => @document
    else
      render :action => 'edit'
    end
  end

  def destroy
    Document.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
  
  def ajax_suggest_register_number
    # I probably should check security validations for the found committee, probably
    if request.raw_post == ""
      # user probably selected the blank line, let's just let it alone
      render(:layout => false)
      return
    end
    selected_committee = Committee.find(request.raw_post)
    @latest_register_number = selected_committee.suggest_new_register_number
    render(:layout => false)
  end
  
  def download
    doc = Document.find(params[:id])
    # check current user for appropriate security permissions
    # ".doc" needs to be changed, obviously
    send_data(doc.file,
      :filename => doc.title + doc.extension,
      :disposition => "attachment")
  end
  
  def downloadpdf
    doc = Document.find(params[:id])
    # check current user for appropriate security permissions
    # ".doc" needs to be changed, obviously
    send_data(doc.pdffile,
      :filename => doc.title + ".pdf",
      :type => "application/pdf",
      :disposition => "attachment")
  end
end
