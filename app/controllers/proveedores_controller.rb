class ProveedoresController < ApplicationController
  before_filter :login_required
  def index
    @proveedores = Proveedore.all
  end

  def new
    @proveedores = Proveedore.new
  end

  def create
    @proveedores = Proveedore.new(params[:proveedore])
    @proveedores.compra_total = 0
    @proveedores.compra_mes_pasado = 0
    ultimo = Proveedore.all
    if ultimo.size == 0
      @proveedores.proveedor_id=1
    else
      @proveedores.proveedor_id=ultimo[-1].proveedor_id + 1
    end

    if @proveedores.save
      flash[:notice]="Articulo guardado correctamente"
      redirect_to(@proveedores)
    else
      render :new
    end
  end

end
