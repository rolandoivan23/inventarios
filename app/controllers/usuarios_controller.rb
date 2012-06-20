class UsuariosController < ApplicationController
#before_filter :login_required
include AuthenticatedSystem
def index
  @usuarios = Usuarios.all

end
  # render new.rhtml
  def new
    @usuarios = Usuarios.new
    @areas = Area.all
    @tipos_usuario = TipoUsuario.all
  end

  def create
    @usuarios = Usuarios.new(params[:usuarios])
    @usuarios.area_id = params[:usuarios][:area_id]
    @usuarios.direccion = params[:usuarios][:direccion]
    @usuarios.telefono = params[:usuarios][:telefono]
    @usuarios.tipo_usuario_id = params[:usuarios][:tipo_usuario_id]
   if  @usuarios.save
    
            # Protects against session fixation attacks, causes request forgery
      # protection if visitor resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset session
 
      redirect_to :controller => "usuarios", :action=> "new"
    else
      flash.now[:error]  = "We couldn't set up that account, sorry.  Please try again, or contact an admin (link is above)."
      redirect_to :controller => "inicio", :action=> "index"
    end
  end

  def nuevo

    @usuarios = Usuarios.new(params[:usuarios])
        @usuarios.direccion=params[:direccion]
    @usuarios.name=params[:name]
    @usuarios.telefono=params[:telefono]
    @usuarios.tipo_usuario_id=1
    @usuarios.area_id=1
    @usuarios.save
  end
end