class OrdeneArticulo < ActiveRecord::Base
  set_table_name :ordenes_articulos
  set_primary_key :orden_id and :articulo_id
end
