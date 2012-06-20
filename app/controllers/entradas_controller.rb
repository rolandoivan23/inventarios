require 'java'


class EntradasController < ApplicationController
  before_filter :login_required
  def index
   @entradas_mes = Entradas.find_by_sql("select * from entradas where extract(month from sysdate) = extract(month from fecha)")
  end

  def dar_entrada
    @orden = Ordene.find_by_orden_id(params[:orden_id])
    @arts_orden = OrdeneArticulo.find_all_by_orden_id(@orden.orden_id)
  end

  def ordenes_entrada
    @ordenes_pendientes = Ordene.where("estatus = ? or estatus = ? ", "pe", "pa")
  end

  def verificar_cantidades
    @arts_orden = OrdeneArticulo.find_all_by_orden_id(params[:orden_id])
    i = 0
    ban = 0
    @arts_orden.each do |articulo|
      param = "#{i}"
      cad = params[param]
      cad2 = "#{@arts_orden[i].cantidad}"
        if cad > cad2
          ban = 1
          flash[:notice] = "Imposible dar entrada a una cantidad maxima que la pedida"
          redirect_to :controller => "entradas", :action => "dar_entrada"
        end
        i = i + 1
    end
    i = 0
    ban_es = 0
    if ban == 0
     

       @orden = Ordene.find_by_orden_id(params[:orden_id])
      @artss_orden = OrdeneArticulo.find_all_by_orden_id(params[:orden_id])
      @artss_orden.each do |arti|
        param = "#{i}"
        cad = params[param]
        cad2 = "#{@artss_orden[i].cantidad}"
        if Integer(cad) > 0
         ultima_ent = Entradas.all
      @entrada = Entradas.new
      if ultima_ent.size == 0
        @entrada.entrada_id = 1
      else
        @entrada.entrada_id=ultima_ent[-1].entrada_id + 1
      end
      @entrada.articulo_id = arti.articulo_id
      @entrada.usuario_entrada_id = self.current_usuarios.id
      @entrada.orden_compra_id = params[:orden_id]
      @entrada.cantidad = Integer(cad)
      @entrada.fecha=Time.now
      @entrada.save
        end
        
        @art = Articulo.find_by_articulo_id(arti.articulo_id)
        new_stock = @art.stock + Integer(cad)
        @art.stock = new_stock
        @art.save
        if ban_es == 0 and cad < cad2
          @orden.estatus= "pa"
          ban_es = 1
          arti.cantidad = arti.cantidad - Integer(cad)
          arti.save
        end
        i = i+1
      end

      if ban_es == 0
        @orden.estatus = "en"
      end
      @orden.save
      redirect_to :controller => "entradas", :action => "index"
    end
  end
end
