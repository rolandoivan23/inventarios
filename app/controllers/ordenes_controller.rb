class OrdenesController < ApplicationController
  before_filter :login_required
  def index
    @requis_pendientes = Requisicione.where("estatus = ?", 0)
  end

  def checar_requisicion
    req_id = params[:requisicion_id]
    @arts_requi = RequisicioneArticulo.where("requisicion_id = ?", req_id)
    @estatus = EstatuRequisicione.all
  end

  def crear_orden
    @requi = Requisicione.find_by_requisicion_id(params[:requisicion_id])
    ultima = Ordene.all
   if params[:estatus_id][:estatus_id] == "2"
      @orden = Ordene.new
      if ultima.size == 0
        @orden.orden_id = 1
      else
        @orden.orden_id = ultima[-1].orden_id + 1
      end
      @orden.requisicion_id = params[:requisicion_id]
      @orden.fecha = Time.now
      @orden.peticion_usuario_id = @requi.usuario_id
      @orden.autorizacion_usuario_id = self.current_usuarios.id
      @orden.proveedor_id = @requi.proveedor_id
      @orden.total = @requi.total
      @orden.estatus = "pe"
      @orden.save
      @requi.update_attribute("estatus", 1)
      arts_orden = RequisicioneArticulo.find_all_by_requisicion_id(@orden.requisicion_id)
      arts_orden.each do |articulo|
          @art_orden = OrdeneArticulo.new
          @art_orden.orden_id = @orden.orden_id
          @art_orden.articulo_id = articulo.articulo_id
          @art_orden.cantidad = articulo.cantidad
          @art_orden.precio = articulo.precio
          @art_orden.sub_total = articulo.sub_total
          @art_orden.save
      end
      redirect_to :controller => "ordenes", :action => "index"
   end
  end
end
