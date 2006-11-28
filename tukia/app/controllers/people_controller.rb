class PeopleController < ApplicationController
  layout "standard"
  before_filter :login_required, :except => [ :login ]
  
  def index
    list
    render :action => 'list'
  end
  
  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @person_pages, @people = paginate :people, :per_page => 10
  end

  def show
    @person = Person.find(params[:id])
  end

  def new
    @person = Person.new
    @person.enabled = true
  end

  def create
    @person = Person.new(params[:person])
    saveresult = @person.save
    if (saveresult || saveresult.nil?)
      flash[:notice] = 'Person was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @person = Person.find(params[:id])
    @person.password = ""
  end

  def update
    @person = Person.find(params[:id])
    
    #this fixes the clearing-checkbox bug, as documented in the CheckboxHABTM article on the wiki.
    if !params['person']['nation_ids']
      @person.nations.clear
    end
    
    updateresult = @person.update_attributes(params[:person])
    if (updateresult || updateresult.nil?)
      flash[:notice] = 'Person was successfully updated.'
      redirect_to :action => 'show', :id => @person
    else
      render :action => 'edit'
    end
  end

  def destroy
    Person.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
  
  def login
    case @request.method
      when :post
      if @session[:user] = Person.authenticate(@params[:user_login], @params[:user_password])

        flash['notice']  = "Login successful".t
        @session[:user].update_login_time()
        redirect_back_or_default :controller => "site", :action => "welcome"
      else
        flash.now['notice']  = "Login unsuccessful".t

        @login = @params[:user_login]
      end
    end
  end
  
#  def signup
#    @user = Person.new(@params[:user])
#
#    if @request.post? and @user.save
#      @session[:user] = User.authenticate(@user.name, @params[:user][:password])
#      flash['notice']  = "Signup successful".t
#      redirect_back_or_default :action => "welcome"
#    end
#  end
  
  def logout
    @session[:user] = nil
  end
end
