class InicioController < ApplicationController
  before_filter :login_required
  def index
    @current_user=self.current_usuarios
    @art_punto_reorden = Articulo.where("stock = punto_reorden or stock < punto_reorden")
  end

end
