require File.dirname(__FILE__) + '/../test_helper'
require 'usuarios_controller'

# Re-raise errors caught by the controller.
class UsuariosController; def rescue_action(e) raise e end; end

class UsuariosControllerTest < ActionController::TestCase
  # Be sure to include AuthenticatedTestHelper in test/test_helper.rb instead
  # Then, you can remove it from this and the units test.
  include AuthenticatedTestHelper

  fixtures :usuarios

  def test_should_allow_signup
    assert_difference 'Usuarios.count' do
      create_usuarios
      assert_response :redirect
    end
  end

  def test_should_require_login_on_signup
    assert_no_difference 'Usuarios.count' do
      create_usuarios(:login => nil)
      assert assigns(:usuarios).errors.on(:login)
      assert_response :success
    end
  end

  def test_should_require_password_on_signup
    assert_no_difference 'Usuarios.count' do
      create_usuarios(:password => nil)
      assert assigns(:usuarios).errors.on(:password)
      assert_response :success
    end
  end

  def test_should_require_password_confirmation_on_signup
    assert_no_difference 'Usuarios.count' do
      create_usuarios(:password_confirmation => nil)
      assert assigns(:usuarios).errors.on(:password_confirmation)
      assert_response :success
    end
  end

  def test_should_require_email_on_signup
    assert_no_difference 'Usuarios.count' do
      create_usuarios(:email => nil)
      assert assigns(:usuarios).errors.on(:email)
      assert_response :success
    end
  end
  

  

  protected
    def create_usuarios(options = {})
      post :create, :usuarios => { :login => 'quire', :email => 'quire@example.com',
        :password => 'quire69', :password_confirmation => 'quire69' }.merge(options)
    end
end
