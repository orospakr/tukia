require File.dirname(__FILE__) + '/../test_helper'
require 'nations_controller'

# Re-raise errors caught by the controller.
class NationsController; def rescue_action(e) raise e end; end

class NationsControllerTest < Test::Unit::TestCase
  fixtures :nations
  fixtures :people

  def setup
    @controller = NationsController.new
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

    assert_not_nil assigns(:nations)
  end

  def test_show
    login_as(:joeblow)
    get :show, :id => 1

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:nation)
    assert assigns(:nation).valid?
  end

  def test_new
    login_as(:joeblow)
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:nation)
  end

  def test_create
    login_as(:joeblow)
    num_nations = Nation.count

    post :create, :nation => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_nations + 1, Nation.count
  end

  def test_edit
    login_as(:joeblow)
    get :edit, :id => 1

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:nation)
    assert assigns(:nation).valid?
  end

  def test_update
    login_as(:joeblow)
    post :update, :id => 1
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => 1
  end

  def test_destroy
    login_as(:joeblow)
    assert_not_nil Nation.find(1)

    post :destroy, :id => 1
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      Nation.find(1)
    }
  end
end
