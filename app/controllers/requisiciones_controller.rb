class RequisicionesController < ApplicationController
  before_filter :login_required
  def index
    @requis_mes = Requisicione.find_by_sql("select * from requisiciones where extract(month from sysdate) = extract(month from fecha)")
   
  end

  def new
    @requi = Requisicione.all :order => "requisicion_id"
    @requi = @requi[-1]
    @arts_requi = RequisicioneArticulo.where("requisicion_id = ?",@requi.requisicion_id)
  end

  def crear_requi
    ultima = Requisicione.all :order => "requisicion_id"
    @requi = Requisicione.new
    if ultima.size == 0
      @requi.requisicion_id = 1
    else
      @requi.requisicion_id = ultima[-1].requisicion_id + 1
    end
    prov = Proveedore.find_by_proveedor_id(params[:proveedor_id][:proveedor_id])
    @requi.proveedor_id= params[:proveedor_id][:proveedor_id]
    
    @requi.usuario_id = self.current_usuarios.id
    @requi.fecha = Time.now
    @requi.estatus = "0"
    @requi.total = 0
    if @requi.save
      redirect_to :controller => "requisiciones", :action => "new"
    else
      redirect_to :controller => "requisiciones", :action => "seleccionar_proveedor"
    end
  end

  def agregar_articulo
    @requi_id = Requisicione.find_by_requisicion_id(params[:requisicion_id])
    @requi_id = @requi_id.requisicion_id
    @articulos = Articulo.all
    @arts_requi = RequisicioneArticulo.find_all_by_requisicion_id(@requi_id)
  end


  def seleccionar_proveedor
    @proveedores = Proveedore.all
  end

  def datos_articulo
    @requisicion = RequisicioneArticulo.all
    @requisicion = @requisicion[-1]
    art_id = params[:articulo_id]
    @articulo = Articulo.find_by_articulo_id(art_id)
    
  end

  def guardar_datos_articulo

    @art_requi = RequisicioneArticulo.new
    @art_requi.requisicion_id = params[:requisicion_id]
    @art_requi.articulo_id = params[:articulo_id]
    @art_requi.cantidad = params[:cantidad]
    @art_requi.precio = params[:precio]
    @art_requi.sub_total = @art_requi.precio * @art_requi.cantidad
    @art_requi.save
    redirect_to :controller => "requisiciones", :action => "new"
  end

  def finalizar
    req_id = params[:requisicion_id]
    @requisicion = Requisicione.find_by_requisicion_id(req_id)
    @articulos = RequisicioneArticulo.find_all_by_requisicion_id(req_id)
    if @articulos.size != 0
      total = 0
      @articulos.each do |articulo|
        total = total + articulo.sub_total
      end
      @requisicion.update_attribute("total",total)
      redirect_to :controller => "requisiciones", :action => "index"
    else
      flash[:notice] = "Imposible poder crear la requisicion"
      redirect_to :controller => "requisiciones", :action => "new"
    end
  end
end
