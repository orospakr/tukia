require File.dirname(__FILE__) + '/../test_helper'
require 'reports_controller'

# Re-raise errors caught by the controller.
class ReportsController; def rescue_action(e) raise e end; end

class ReportsControllerTest < Test::Unit::TestCase
  fixtures :reports

  def setup
    @controller = ReportsController.new
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

    assert_not_nil assigns(:reports)
  end

  def test_show
    login_as(:joeblow)
    get :show, :id => 1

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:report)
    assert assigns(:report).valid?
  end

  def test_new
    login_as(:joeblow)
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:report)
  end

  def test_create
    login_as(:joeblow)
    num_reports = Report.count

    post :create, :report => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_reports + 1, Report.count
  end

  def test_edit
    login_as(:joeblow)
    get :edit, :id => 1

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:report)
    assert assigns(:report).valid?
  end

  def test_update
    login_as(:joeblow)
    post :update, :id => 1
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => 1
  end

  def test_destroy
    login_as(:joeblow)
    assert_not_nil Report.find(1)

    post :destroy, :id => 1
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      Report.find(1)
    }
  end
end
