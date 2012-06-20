class SalidasController < ApplicationController
  before_filter :login_required
  def index
     @salidas_mes = Salida.find_by_sql("select * from salidas where extract(month from sysdate) = extract(month from fecha)")
  end

  def dar_salida
    @articulo = Articulo.find_by_articulo_id(params[:articulo_id])
  end

  def articulos_salida
    @articulos_salida = Articulo.where("stock > ?", 0)
  end

  def verificar_salida
    @articulo = Articulo.find_by_articulo_id(params[:articulo_id])
    canti_sal = params[:cantidad]
    stock = "#{@articulo.stock}"
    if canti_sal > stock
      flash[:notoce] = "Cantidad invalida"
      redirect_to :controller => "salidas", :action => "dar_salida"
    else
      @articulo.stock= @articulo.stock - Integer(canti_sal)
      @articulo.save
      ultima = Salida.all
      @salida = Salida.new
      if ultima.size == 0
        @salida.salida_id = 1
      else
        @salida.salida_id=ultima[-1].salida_id + 1
      end
      @salida.articulo_id = params[:articulo_id]
      @salida.usuario_salida_id = self.current_usuarios.id
      @salida.cantidad = Integer(canti_sal)
      @salida.fecha=Time.now
      @salida.save
      redirect_to :controller => "salidas", :action => "articulos_salida"
    end
  end
end
