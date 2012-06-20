alter table usuarios
add (area_id number(10), direccion varchar2(100), tipo_usuario_id number(10), telefono varchar2(20));
			
create table tipo_usuario (tipo_usuario_id number(10), tipo varchar2(10) not null, descripcion varchar2(200),
				constraint pkey_tipo_usuario primary key(tipo_usuario_id));
				
alter table usuarios 
add constraint fkey_tipo_usuario foreign key(tipo_usuario_id) references tipo_usuario(tipo_usuario_id);

create table areas (area_id number(10), nombre varchar2(100) not null, encargado number(10), compras_tot float not null,
			compras_ultimo_mes float not null,
			constraint pkey_areas primary key(area_id),
			constraint fkey_encargado foreign key(encargado) references usuarios(id),
			constraint chk_comp_tot check((compras_tot>0) or (compras_tot=0)),
			constraint chk_comp_ult_mes check((compras_ultimo_mes>0) or (compras_ultimo_mes=0)));
			
alter table usuarios
add constraint fkey_area foreign key(area_id) references areas(area_id);

create table articulos (articulo_id number(10), descripcion varchar2(200) not null,  stock number(5) not null, 		 		precio_ultima_compra float default 0, punto_reorden number(5) not null,
			 constraint pkey_articulos primary key(articulo_id),
			 constraint chk_stock check((stock>0) or (stock=0)),
			 constraint chk_ultimo_precio check((precio_ultima_compra>0) or (precio_ultima_compra=0)), 
			 constraint chk_punto_reorden check((punto_reorden>0) or (punto_reorden=0)));
			 
create table proveedores (proveedor_id number(10), nombre varchar2(100) not null, contacto varchar2(100), 
			direccion varchar2(100) not null, telefono varchar2(40) not null, compra_total float,
			compra_mes_pasado float, 
			constraint pkey_prov primary key(proveedor_id),
			constraint chk_compra_total check((compra_total=0) or (compra_total>0)),
			constraint chk_compra_mes check((compra_mes_pasado=0) or (compra_mes_pasado>0)));
			 
create table requisiciones (requisicion_id number(10), usuario_id number(10), proveedor_id number(10), 
				fecha date default sysdate, total float not null, estatus varchar2(20) not null,
				constraint pkey_requis primary key(requisicion_id), 
				constraint fkey_usuarios foreign key(usuario_id) references usuarios(id),
				constraint fkey_prov foreign key(proveedor_id) references proveedores(proveedor_id),
				constraint chk_total check((total=0) or (total>0)));
				
create table requisiciones_articulos (requisicion_id number(10), articulo_id number(10), cantidad number(5) not null,
			precio float not null, sub_total float not null,
			constraint prm_key_req_art primary key(requisicion_id, articulo_id),
			constraint fkey_arts foreign key(articulo_id) references articulos(articulo_id),
			constraint fkey_requi foreign key(requisicion_id) references requisiciones(requisicion_id),
			constraint chk_cantidad check((cantidad > 0) or (cantidad = 0)),
			constraint chk_precio check((precio > 0) or (precio = 0)));
			
create table estatus_requisiciones (estatus_id number(5), estatus varchar2(80) not null, 
				descripcion varchar2(200) not null,
				constraint pkey_estatus_req primary key(estatus_id));
			
create table ordenes (orden_id number(10), requisicion_id number(10), fecha date default sysdate, 
			peticion_usuario_id number(10), autorizacion_usuario_id number(10), proveedor_id number(10),
			total float not null, estatus varchar2(5) not null,
			constraint pkey_ordenes primary key(orden_id),
			constraint fkey_usuarios_ord foreign key(peticion_usuario_id) references usuarios(id),
			constraint fkey_usuario_ord foreign key(autorizacion_usuario_id) references usuarios(id),
			constraint fkey_prov_ord foreign key(proveedor_id) references proveedores(proveedor_id),
			constraint chk_ot_ord check((total > 0) or (total = 0)));
			
create table ordenes_articulos (orden_id number(10), articulo_id number(10), cantidad number(5) not null,
			 precio float not null, sub_total float not null,
			 constraint pkey_ord_art primary key(orden_id, articulo_id),
			 constraint fkey_arts_ord foreign key(articulo_id) references articulos(articulo_id),
			 constraint fkey_requi_ord foreign key(orden_id) references ordenes(orden_id),
			 constraint chk_cantidad_ord check((cantidad > 0) or (cantidad = 0)),
			 constraint chk_precio_ord check((precio > 0) or (precio = 0)));
			 
create table salidas (salida_id number(10), articulo_id number(10), usuario_salida_id number(10), cantidad number(5),
			constraint pkey_salidas primary key(salida_id),
			constraint fkey_art_sal foreign key(articulo_id) references articulos(articulo_id),
			constraint fkey_usu_sal foreign key(usuario_salida_id) references usuarios(id));
			
create table entradas (entrada_id number(10), articulo_id number(10), orden_compra_id number(10), 
			usuario_entrada_id number(10), cantidad number(5),
			constraint pkey_entradas primary key(entrada_id),
			constraint fkey_art_ent foreign key(articulo_id) references articulos(articulo_id),
			constraint fkey_orden_ent foreign key(orden_compra_id) references ordenes(orden_id),
			constraint fkey_usua_ent foreign key(usuario_entrada_id) references usuarios(id));

alter table salidas
add fecha date default sysdate;

alter table entradas
add fecha date default sysdate;

