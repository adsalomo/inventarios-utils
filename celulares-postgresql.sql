create table categorias(
	categoria_id int not null,
	nombre varchar(100) not null,
	primary key(categoria_id)
);

create table marcas(
	marca_id int not null,
	nombre varchar(100) not null,
	primary key(marca_id)
);

create table productos(
	producto_id serial not null,
	nombre varchar(100) not null,
	categoria_id int not null,
	marca_id int not null,
	precio float not null,
	inventario int not null,
	fecha_creacion timestamp not null,
	primary key(producto_id),
	foreign key(categoria_id) references categorias(categoria_id),
	foreign key(marca_id) references marcas(marca_id)
);

create table tipo_cliente(
	tipo_cliente_id int not null,
	nombre varchar(100) not null,
	primary key(tipo_cliente_id)
);

create table clientes(
	cliente_id serial not null,
	nombre varchar(100) not null,
	nit varchar(50) not null,
	fecha_nacimiento timestamp not null,
	tipo_cliente_id int not null,
	telefono varchar(100) not null,
	direccion varchar(100) not null,
	fecha_creacion timestamp not null,
	primary key(cliente_id),
	foreign key(tipo_cliente_id) references tipo_cliente(tipo_cliente_id),
	unique(nit)
);

-- CATEGORIAS
INSERT INTO categorias (categoria_id, nombre) values (1, 'Usados');
INSERT INTO categorias (categoria_id, nombre) values (2, 'Nuevos');
INSERT INTO categorias (categoria_id, nombre) values (3, 'Reportados');

-- MARCAS
insert into marcas (marca_id, nombre) values (1, 'Xiaomi');
insert into marcas (marca_id, nombre) values (2, 'Huawei');
insert into marcas (marca_id, nombre) values (3, 'Lenovo');
insert into marcas (marca_id, nombre) values (4, 'LG');
insert into marcas (marca_id, nombre) values (5, 'Samsung');
insert into marcas (marca_id, nombre) values (6, 'Motorola');

-- PRODUCTOS
insert into productos (nombre, categoria_id, marca_id, precio, inventario, 
fecha_creacion) values ('Xiaomi Redmi Note 11 Dual SIM', 2, 1, 759900, 20, now());
insert into productos (nombre, categoria_id, marca_id, precio, inventario, 
fecha_creacion) values ('Xiaomi Redmi 10 Dual SIM 32 GB', 2, 1, 950000, 10, now());
insert into productos (nombre, categoria_id, marca_id, precio, inventario, 
fecha_creacion) values ('Samsung Galaxy A32', 1, 5, 889900, 20, '2022-10-10');
insert into productos (nombre, categoria_id, marca_id, precio, inventario, 
fecha_creacion) values ('Moto G31 Dual SIM 128 GB', 1, 6, 889900, 20, '2022-05-06');
insert into productos (nombre, categoria_id, marca_id, precio, inventario, 
fecha_creacion) values ('Huawei Y9a Dual SIM 128 GB', 1, 2, 849900, 6, '2022-09-01');
insert into productos (nombre, categoria_id, marca_id, precio, inventario, 
fecha_creacion) values ('Xiaomi Redmi Note 11S Dual SIM', 1, 1, 907900, 2, '2022-01-10');

-- CLAUSULAS

-- mostrar todos los productos con su respectivo nombre de categoria y marca para
select p.producto_id, p.nombre nombre_producto, p.categoria_id, c.nombre nombre_categoria,
p.marca_id, m.nombre nombre_marca, p.precio, p.inventario, p.fecha_creacion
from productos p 
inner join categorias c on p.categoria_id = c.categoria_id
inner join marcas m on p.marca_id = m.marca_id;

-- mostrar todos los productos con su respectivo nombre de categoria y marca para
-- donde la categoria sea igual a 1, pero mostrar tambien los que no coincidan
select p.producto_id, p.nombre nombre_producto, p.categoria_id, c.nombre nombre_categoria,
p.marca_id, m.nombre nombre_marca, p.precio, p.inventario, p.fecha_creacion
from productos p 
left join categorias c on p.categoria_id = c.categoria_id and p.categoria_id = 1
inner join marcas m on p.marca_id = m.marca_id;

-- listar todos los productos con el nombre de la categoria, marca
-- ordenados por el precio
select p.producto_id, p.nombre nombre_producto, p.categoria_id, c.nombre nombre_categoria,
p.marca_id, m.nombre nombre_marca, p.precio, p.inventario, p.fecha_creacion
from productos p 
inner join categorias c on p.categoria_id = c.categoria_id
inner join marcas m on p.marca_id = m.marca_id
order by p.precio;

-- listar todos los productos con el nombre de la categoria, marca
-- ordenados por el precio
select p.producto_id, p.nombre nombre_producto, p.categoria_id, c.nombre nombre_categoria,
p.marca_id, m.nombre nombre_marca, p.precio, p.inventario, p.fecha_creacion
from productos p 
inner join categorias c on p.categoria_id = c.categoria_id
inner join marcas m on p.marca_id = m.marca_id
order by p.precio desc;

-- identificar cuantos productos existen por cada marca
select marca_id, count(*) from productos p group by p.marca_id;

-- buscar las marcas que tengan 3 o más productos
select marca_id, count(*) from productos p group by p.marca_id having count(*) >= 3;

-- LOGICOS

-- buscar los productos que sean de la marca xiaomi
select * from productos p where p.marca_id = 1;

-- buscar los productos que sean de la marca xiaomi y de la categoria nuevos
select * from productos p where p.marca_id = 1 and p.categoria_id = 2;

-- buscar los productos que sean de la marca xiaomi o de la marca samsung
select * from productos p where p.marca_id = 1 or p.marca_id = 5;
select * from productos p where p.marca_id in (1, 5);

-- buscar los productos que no sean de la marca xiaomi y de la marca samsung
select * from productos p where p.marca_id not in (1, 5);

-- COMPARACION

-- buscar los productos en donde su precio sea mayor a 700.000 pero menor a 800.000
select * from productos p where p.precio > 700000 and p.precio < 800000;

-- buscar los productos en donde su precio sea mayor a 700.000 pero menor a 900.000
select * from productos p where p.precio > 700000 and p.precio < 900000;

-- buscar los productos en donde su precio sea mayor a 889.900
select * from productos p where p.precio > 889900;

-- buscar los productos en donde su precio sea mayor o igual a 889.900
select * from productos p where p.precio >= 889900;

-- buscar los productos en donde su categoria sea distinta a usados
select * from productos p where p.categoria_id <> 1;

-- buscar los productos en donde la fecha de creacion este entre septiempre y octubre 2022
select * 
from productos p 
where cast(p.fecha_creacion as date) between '2022-09-01' and '2022-10-31';

select * 
from productos p 
where p.fecha_creacion between '2022-09-01 00:00:000' and '2022-10-31 23:59:59';
