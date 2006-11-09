require File.dirname(__FILE__) + '/../test_helper'
require 'documents_controller'

# Re-raise errors caught by the controller.
class DocumentsController; def rescue_action(e) raise e end; end

class DocumentsControllerTest < Test::Unit::TestCase
  fixtures :documents

  def setup
    @controller = DocumentsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_index
    login_as(:joeblow)
    get :index
    assert_response :success
    assert_template 'list'
  end

  def test_list
    login_as(:joeblow)
    get :list

    assert_response :success
    assert_template 'list'

    assert_not_nil assigns(:documents)
  end

  def test_show
    login_as(:joeblow)
    get :show, :id => 1

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:document)
    assert assigns(:document).valid?
  end

  def test_new
    login_as(:joeblow)
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:document)
  end

  def test_create
    login_as(:joeblow)
    num_documents = Document.count

    post :create, :document => {:person_id => 1, :committee_id => 1,
                                :title => "Title!", :register_number => 1,
                                :file => "Text!",
                                :copyright => "Copyright", :licence => "Licence"}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_documents + 1, Document.count
  end

  def test_edit
    login_as(:joeblow)
    get :edit, :id => 1

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:document)
    assert assigns(:document).valid?
  end

  def test_update
    login_as(:joeblow)
    post :update, :id => 1
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => 1
  end

  def test_destroy
    login_as(:joeblow)
    assert_not_nil Document.find(1)

    post :destroy, :id => 1
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      Document.find(1)
    }
  end
end
