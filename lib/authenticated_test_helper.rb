module AuthenticatedTestHelper
  # Sets the current usuarios in the session from the usuarios fixtures.
  def login_as(usuarios)
    @request.session[:usuarios_id] = usuarios ? (usuarios.is_a?(Usuarios) ? usuarios.id : usuarios(usuarios).id) : nil
  end

  def authorize_as(usuarios)
    @request.env["HTTP_AUTHORIZATION"] = usuarios ? ActionController::HttpAuthentication::Basic.encode_credentials(usuarios(usuarios).login, 'monkey') : nil
  end
  
end
