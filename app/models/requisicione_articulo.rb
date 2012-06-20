class RequisicioneArticulo < ActiveRecord::Base
  set_table_name :requisiciones_articulos
  set_primary_key :requisicion_id and :articulo_id
end
