require File.dirname(__FILE__) + '/../test_helper'
require 'committees_controller'

# Re-raise errors caught by the controller.
class CommitteesController; def rescue_action(e) raise e end; end

class CommitteesControllerTest < Test::Unit::TestCase
  fixtures :committees

  def setup
    @controller = CommitteesController.new
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

    assert_not_nil assigns(:committees)
  end

  def test_show
    login_as(:joeblow)
    get :show, :id => 1

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:committee)
    assert assigns(:committee).valid?
  end

  def test_new
    login_as(:joeblow)
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:committee)
  end

  def test_create
    login_as(:joeblow)
    num_committees = Committee.count

    post :create, :committee => {:name => "Committee created by test_create!"}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_committees + 1, Committee.count
  end

  def test_edit
    login_as(:joeblow)
    get :edit, :id => 1

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:committee)
    assert assigns(:committee).valid?
  end

  def test_update
    login_as(:joeblow)
    post :update, :id => 1
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => 1
  end

  def test_destroy
    login_as(:joeblow)
    assert_not_nil Committee.find(1)

    post :destroy, :id => 1
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      Committee.find(1)
    }
  end
end
