class ArticulosController < ApplicationController

 before_filter :login_required
  def index
    @articulos = Articulo.all
  end
  def new
    @articulo=Articulo.new
  end

  def create
    @articulo=Articulo.new(params[:articulo])
    ultimo=Articulo.all
    if ultimo.size == 0
      @articulo.articulo_id=1
    else
      @articulo.articulo_id=ultimo[-1].articulo_id + 1
    end
    
    @articulo.precio_ultima_compra=0
    @articulo.stock=0
    if @articulo.save
      flash[:notice]="Articulo guardado correctamente"
      redirect_to(@articulo)
    else
      render :new
    end
  end
end
