class AreasController < ApplicationController

before_filter :login_required
  def index
    @areas = Area.all
  end

  def new
    @area=Area.new
    @usuarios=Usuarios.all
  end

  def create
  
    @area=Area.new
    ultima=Area.all
    if ultima.size == 0
      @area.area_id = 1
    else
      @area.area_id=ultima[-1].area_id + 1
    end
    @area.nombre=(params[:area][:nombre])
    @area.encargado=Integer((params[:area][:encargado]))
    @area.compras_tot = 0
    @area.compras_ultimo_mes = 0
    if @area.save
      flash[:notice] = 'Area guardada correctamente'
      redirect_to(@area)
    else
      render :action => "new"
    end
  end

end
