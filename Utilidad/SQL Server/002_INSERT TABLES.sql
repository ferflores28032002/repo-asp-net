USE DBVENTAS_WEB
GO

-- REGISTROS EN TABLA ROL
INSERT INTO ROL(Descripcion) VALUES
('ADMINISTRADOR'),
('EMPLEADO'),
('GERENTE DE TIENDA'),
('ASISTENTE DE VENTAS'),
('CAJERO'),
('ENCARGADO DE INVENTARIO'),
('ENCARGADO DE COMPRAS'),
('SUPERVISOR DE SECCIÓN'),
('ENCARGADO DE ATENCIÓN AL CLIENTE'),
('ENCARGADO DE MARKETING');
GO

-- REGISTROS EN TABLA MENU
INSERT INTO MENU(Nombre, Icono) VALUES
('Gestión de Datos', 'fas fa-tools'),
('Clientes', 'fas fa-user-friends'),
('Compras', 'fas fa-cart-arrow-down'),
('Ventas', 'fas fa-cash-register'),
('Reportes', 'far fa-clipboard');
GO

-- Inserta en el submenú con el nuevo nombre del menú
INSERT INTO SUBMENU(IdMenu, Nombre, Controlador, Vista, Icono) VALUES
((SELECT TOP 1 IdMenu FROM MENU WHERE Nombre = 'Gestión de Datos'), 'Rol', 'Rol', 'Crear', 'fas fa-user-tag'),
((SELECT TOP 1 IdMenu FROM MENU WHERE Nombre = 'Gestión de Datos'), 'Asignar Permisos', 'Permisos', 'Crear', 'fas fa-user-lock'),
((SELECT TOP 1 IdMenu FROM MENU WHERE Nombre = 'Gestión de Datos'), 'Usuarios', 'Usuario', 'Crear', 'fas fa-users-cog'),
((SELECT TOP 1 IdMenu FROM MENU WHERE Nombre = 'Gestión de Datos'), 'Categorias', 'Categoria', 'Crear', 'fab fa-wpforms'),
((SELECT TOP 1 IdMenu FROM MENU WHERE Nombre = 'Gestión de Datos'), 'Productos', 'Producto', 'Crear', 'fas fa-box-open'),
((SELECT TOP 1 IdMenu FROM MENU WHERE Nombre = 'Clientes'), 'Clientes', 'Cliente', 'Crear', 'fas fa-user-shield'),
((SELECT TOP 1 IdMenu FROM MENU WHERE Nombre = 'Compras'), 'Proveedores', 'Proveedor', 'Crear', 'fas fa-shipping-fast'),
((SELECT TOP 1 IdMenu FROM MENU WHERE Nombre = 'Compras'), 'Asignar producto a Tienda', 'Producto', 'Asignar', 'fas fa-dolly'),
((SELECT TOP 1 IdMenu FROM MENU WHERE Nombre = 'Compras'), 'Registrar Compra', 'Compra', 'Crear', 'fas fa-cart-arrow-down'),
((SELECT TOP 1 IdMenu FROM MENU WHERE Nombre = 'Compras'), 'Consultar Compra', 'Compra', 'Consultar', 'far fa-list-alt'),
((SELECT TOP 1 IdMenu FROM MENU WHERE Nombre = 'Ventas'), 'Tiendas', 'Tienda', 'Crear', 'fas fa-store-alt'),
((SELECT TOP 1 IdMenu FROM MENU WHERE Nombre = 'Ventas'), 'Registrar Venta', 'Venta', 'Crear', 'fas fa-cash-register'),
((SELECT TOP 1 IdMenu FROM MENU WHERE Nombre = 'Ventas'), 'Consultar Venta', 'Venta', 'Consultar', 'far fa-clipboard'),
((SELECT TOP 1 IdMenu FROM MENU WHERE Nombre = 'Reportes'), 'Productos por tienda', 'Reporte', 'Producto', 'fas fa-boxes'),
((SELECT TOP 1 IdMenu FROM MENU WHERE Nombre = 'Reportes'), 'Ventas', 'Reporte', 'Ventas', 'fas fa-shopping-basket');
GO

-- REGISTROS EN TABLA TIENDA
INSERT INTO TIENDA(Nombre, RUC, Direccion, Telefono) VALUES
('Multicentro Las Américas', '12345678901', 'Av. Central 456, Managua', '875412369'),
('Metrocentro', '23456789012', 'Calle Norte 789, Managua', '896523147'),
('Galerías Santo Domingo', '34567890123', 'Av. Sur 123, Managua', '963852741'),
('Plaza España', '45678901234', 'Calle Este 456, Managua', '741852963'),
('Plaza Inter', '56789012345', 'Av. Oeste 789, Managua', '852369741');
GO

-- REGISTROS EN TABLA USUARIO
-- Insertar usuarios
INSERT INTO USUARIO(Nombres, Apellidos, Correo, Clave, IdTienda, IdRol) VALUES
('Marcela', 'Caballo', 'marcela.caballo@gmail.com', '5994471abb01112afcc18159f6cc74b4f511b99806da59b3caf5a9c173cacfc5', (SELECT TOP 1 IdTienda FROM TIENDA WHERE Nombre = 'Multicentro Las Américas'), (SELECT TOP 1 IdRol FROM ROL WHERE Descripcion = 'ADMINISTRADOR')),
('Fernando', 'Flores', 'fernando.flores@gmail.com', '5994471abb01112afcc18159f6cc74b4f511b99806da59b3caf5a9c173cacfc5', (SELECT TOP 1 IdTienda FROM TIENDA WHERE Nombre = 'Multicentro Las Américas'), (SELECT TOP 1 IdRol FROM ROL WHERE Descripcion = 'ADMINISTRADOR')),
('Benjamin', 'Goidito', 'benjamin.goidito@gmail.com', '5994471abb01112afcc18159f6cc74b4f511b99806da59b3caf5a9c173cacfc5', (SELECT TOP 1 IdTienda FROM TIENDA WHERE Nombre = 'Galerías Santo Domingo'), (SELECT TOP 1 IdRol FROM ROL WHERE Descripcion = 'GERENTE DE TIENDA')),
('Norman', 'Santamarina', 'norman.santamarina@gmail.com', '5994471abb01112afcc18159f6cc74b4f511b99806da59b3caf5a9c173cacfc5', (SELECT TOP 1 IdTienda FROM TIENDA WHERE Nombre = 'Plaza España'), (SELECT TOP 1 IdRol FROM ROL WHERE Descripcion = 'CAJERO')),
('Administrador', 'Thopsom', 'admin@gmail.com', '5994471abb01112afcc18159f6cc74b4f511b99806da59b3caf5a9c173cacfc5', (SELECT TOP 1 IdTienda FROM TIENDA WHERE Nombre = 'Multicentro Las Américas'), (SELECT TOP 1 IdRol FROM ROL WHERE Descripcion = 'ADMINISTRADOR'));
GO

-- Asignar permisos al rol de ADMINISTRADOR (todos los permisos activos)
INSERT INTO PERMISOS(IdRol, IdSubMenu, Activo)
SELECT (SELECT TOP 1 IdRol FROM ROL WHERE Descripcion = 'ADMINISTRADOR'), IdSubMenu, 1 FROM SUBMENU;

-- Asignar permisos al rol de EMPLEADO (todos los permisos inactivos)
INSERT INTO PERMISOS(IdRol, IdSubMenu, Activo)
SELECT (SELECT TOP 1 IdRol FROM ROL WHERE Descripcion = 'EMPLEADO'), IdSubMenu, 0 FROM SUBMENU;

-- Asignar permisos a otros roles específicos con permisos activos
INSERT INTO PERMISOS(IdRol, IdSubMenu, Activo)
SELECT (SELECT TOP 1 IdRol FROM ROL WHERE Descripcion = 'GERENTE DE TIENDA'), IdSubMenu, 1 FROM SUBMENU;
INSERT INTO PERMISOS(IdRol, IdSubMenu, Activo)
SELECT (SELECT TOP 1 IdRol FROM ROL WHERE Descripcion = 'ASISTENTE DE VENTAS'), IdSubMenu, 0 FROM SUBMENU;
INSERT INTO PERMISOS(IdRol, IdSubMenu, Activo)
SELECT (SELECT TOP 1 IdRol FROM ROL WHERE Descripcion = 'CAJERO'), IdSubMenu, 0 FROM SUBMENU;
INSERT INTO PERMISOS(IdRol, IdSubMenu, Activo)
SELECT (SELECT TOP 1 IdRol FROM ROL WHERE Descripcion = 'ENCARGADO DE INVENTARIO'), IdSubMenu, 1 FROM SUBMENU;
INSERT INTO PERMISOS(IdRol, IdSubMenu, Activo)
SELECT (SELECT TOP 1 IdRol FROM ROL WHERE Descripcion = 'ENCARGADO DE COMPRAS'), IdSubMenu, 1 FROM SUBMENU;
INSERT INTO PERMISOS(IdRol, IdSubMenu, Activo)
SELECT (SELECT TOP 1 IdRol FROM ROL WHERE Descripcion = 'SUPERVISOR DE SECCIÓN'), IdSubMenu, 1 FROM SUBMENU;
INSERT INTO PERMISOS(IdRol, IdSubMenu, Activo)
SELECT (SELECT TOP 1 IdRol FROM ROL WHERE Descripcion = 'ENCARGADO DE ATENCIÓN AL CLIENTE'), IdSubMenu, 0 FROM SUBMENU;
INSERT INTO PERMISOS(IdRol, IdSubMenu, Activo)
SELECT (SELECT TOP 1 IdRol FROM ROL WHERE Descripcion = 'ENCARGADO DE MARKETING'), IdSubMenu, 1 FROM SUBMENU;
GO

-- Actualizar permisos específicos para el rol de EMPLEADO
UPDATE p SET p.Activo = 1 
FROM PERMISOS p
INNER JOIN SUBMENU sm ON sm.IdSubMenu = p.IdSubMenu
WHERE sm.Controlador IN ('Venta') 
AND p.IdRol = (SELECT TOP 1 IdRol FROM ROL WHERE Descripcion = 'EMPLEADO');
GO

-- REGISTRO EN TABLA CATEGORIA
INSERT INTO CATEGORIA(Descripcion) VALUES
('Cuadernos'),
('Lápices'),
('Bolígrafos'),
('Borradores'),
('Calculadoras'),
('Reglas'),
('Marcadores'),
('Carpetas'),
('Archivadores'),
('Papel'),
('Tijeras'),
('Pegamento'),
('Correctores'),
('Compases'),
('Sacapuntas'),
('Crayones'),
('Plumones'),
('Mochilas'),
('Estuches'),
('Libretas');
GO

--REGISTRO EN TABLA PRODUCTO
-- Insertar productos en diferentes categorías
INSERT INTO PRODUCTO(Codigo, ValorCodigo, Nombre, Descripcion, IdCategoria) VALUES
-- Cuadernos
(RIGHT('000000' + CONVERT(varchar(max), (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO)), 6), (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO), 'Cuaderno A4', 'Cuaderno de 100 hojas', (SELECT TOP 1 IdCategoria FROM CATEGORIA WHERE Descripcion = 'Cuadernos')),
(RIGHT('000000' + CONVERT(varchar(max), (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO)), 6), (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO), 'Cuaderno A5', 'Cuaderno de 200 hojas', (SELECT TOP 1 IdCategoria FROM CATEGORIA WHERE Descripcion = 'Cuadernos')),

-- Lápices
(RIGHT('000000' + CONVERT(varchar(max), (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO)), 6), (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO), 'Lápiz HB', 'Lápiz de grafito HB', (SELECT TOP 1 IdCategoria FROM CATEGORIA WHERE Descripcion = 'Lápices')),
(RIGHT('000000' + CONVERT(varchar(max), (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO)), 6), (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO), 'Lápiz 2B', 'Lápiz de grafito 2B', (SELECT TOP 1 IdCategoria FROM CATEGORIA WHERE Descripcion = 'Lápices')),

-- Borradores
(RIGHT('000000' + CONVERT(varchar(max), (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO)), 6), (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO), 'Borrador Blanco', 'Borrador de goma blanca', (SELECT TOP 1 IdCategoria FROM CATEGORIA WHERE Descripcion = 'Borradores')),
(RIGHT('000000' + CONVERT(varchar(max), (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO)), 6), (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO), 'Borrador de tinta', 'Borrador para tinta', (SELECT TOP 1 IdCategoria FROM CATEGORIA WHERE Descripcion = 'Borradores')),

-- Calculadoras
(RIGHT('000000' + CONVERT(varchar(max), (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO)), 6), (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO), 'Calculadora Científica', 'Calculadora científica con funciones avanzadas', (SELECT TOP 1 IdCategoria FROM CATEGORIA WHERE Descripcion = 'Calculadoras')),
(RIGHT('000000' + CONVERT(varchar(max), (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO)), 6), (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO), 'Calculadora Básica', 'Calculadora básica de bolsillo', (SELECT TOP 1 IdCategoria FROM CATEGORIA WHERE Descripcion = 'Calculadoras')),

-- Reglas
(RIGHT('000000' + CONVERT(varchar(max), (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO)), 6), (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO), 'Regla 30cm', 'Regla de plástico de 30cm', (SELECT TOP 1 IdCategoria FROM CATEGORIA WHERE Descripcion = 'Reglas')),
(RIGHT('000000' + CONVERT(varchar(max), (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO)), 6), (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO), 'Regla 15cm', 'Regla de metal de 15cm', (SELECT TOP 1 IdCategoria FROM CATEGORIA WHERE Descripcion = 'Reglas')),

-- Marcadores
(RIGHT('000000' + CONVERT(varchar(max), (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO)), 6), (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO), 'Marcador Permanente Negro', 'Marcador permanente color negro', (SELECT TOP 1 IdCategoria FROM CATEGORIA WHERE Descripcion = 'Marcadores')),
(RIGHT('000000' + CONVERT(varchar(max), (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO)), 6), (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO), 'Marcador Permanente Rojo', 'Marcador permanente color rojo', (SELECT TOP 1 IdCategoria FROM CATEGORIA WHERE Descripcion = 'Marcadores')),

-- Carpetas
(RIGHT('000000' + CONVERT(varchar(max), (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO)), 6), (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO), 'Carpeta A4', 'Carpeta de plástico tamaño A4', (SELECT TOP 1 IdCategoria FROM CATEGORIA WHERE Descripcion = 'Carpetas')),
(RIGHT('000000' + CONVERT(varchar(max), (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO)), 6), (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO), 'Carpeta con anillos', 'Carpeta con anillos para hojas sueltas', (SELECT TOP 1 IdCategoria FROM CATEGORIA WHERE Descripcion = 'Carpetas')),

-- Archivadores
(RIGHT('000000' + CONVERT(varchar(max), (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO)), 6), (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO), 'Archivador A4', 'Archivador de cartón tamaño A4', (SELECT TOP 1 IdCategoria FROM CATEGORIA WHERE Descripcion = 'Archivadores')),
(RIGHT('000000' + CONVERT(varchar(max), (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO)), 6), (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO), 'Archivador tamaño carta', 'Archivador de cartón tamaño carta', (SELECT TOP 1 IdCategoria FROM CATEGORIA WHERE Descripcion = 'Archivadores')),

-- Papel
(RIGHT('000000' + CONVERT(varchar(max), (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO)), 6), (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO), 'Resma de papel A4', 'Resma de papel blanco tamaño A4', (SELECT TOP 1 IdCategoria FROM CATEGORIA WHERE Descripcion = 'Papel')),
(RIGHT('000000' + CONVERT(varchar(max), (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO)), 6), (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO), 'Resma de papel carta', 'Resma de papel blanco tamaño carta', (SELECT TOP 1 IdCategoria FROM CATEGORIA WHERE Descripcion = 'Papel')),

-- Tijeras
(RIGHT('000000' + CONVERT(varchar(max), (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO)), 6), (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO), 'Tijeras escolares', 'Tijeras de punta redonda para niños', (SELECT TOP 1 IdCategoria FROM CATEGORIA WHERE Descripcion = 'Tijeras')),
(RIGHT('000000' + CONVERT(varchar(max), (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO)), 6), (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO), 'Tijeras profesionales', 'Tijeras de acero inoxidable', (SELECT TOP 1 IdCategoria FROM CATEGORIA WHERE Descripcion = 'Tijeras')),

-- Pegamento
(RIGHT('000000' + CONVERT(varchar(max), (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO)), 6), (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO), 'Pegamento en barra', 'Pegamento en barra 21g', (SELECT TOP 1 IdCategoria FROM CATEGORIA WHERE Descripcion = 'Pegamento')),
(RIGHT('000000' + CONVERT(varchar(max), (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO)), 6), (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO), 'Pegamento líquido', 'Pegamento líquido 50ml', (SELECT TOP 1 IdCategoria FROM CATEGORIA WHERE Descripcion = 'Pegamento')),

-- Correctores
(RIGHT('000000' + CONVERT(varchar(max), (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO)), 6), (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO), 'Corrector líquido', 'Corrector líquido blanco', (SELECT TOP 1 IdCategoria FROM CATEGORIA WHERE Descripcion = 'Correctores')),
(RIGHT('000000' + CONVERT(varchar(max), (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO)), 6), (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO), 'Corrector en cinta', 'Corrector en cinta 5mm x 10m', (SELECT TOP 1 IdCategoria FROM CATEGORIA WHERE Descripcion = 'Correctores')),

-- Compases
(RIGHT('000000' + CONVERT(varchar(max), (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO)), 6), (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO), 'Compás de precisión', 'Compás de precisión metálico', (SELECT TOP 1 IdCategoria FROM CATEGORIA WHERE Descripcion = 'Compases')),
(RIGHT('000000' + CONVERT(varchar(max), (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO)), 6), (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO), 'Compás escolar', 'Compás de plástico para estudiantes', (SELECT TOP 1 IdCategoria FROM CATEGORIA WHERE Descripcion = 'Compases')),

-- Sacapuntas
(RIGHT('000000' + CONVERT(varchar(max), (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO)), 6), (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO), 'Sacapuntas metálico', 'Sacapuntas de metal', (SELECT TOP 1 IdCategoria FROM CATEGORIA WHERE Descripcion = 'Sacapuntas')),
(RIGHT('000000' + CONVERT(varchar(max), (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO)), 6), (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO), 'Sacapuntas doble', 'Sacapuntas de doble entrada', (SELECT TOP 1 IdCategoria FROM CATEGORIA WHERE Descripcion = 'Sacapuntas')),

-- Crayones
(RIGHT('000000' + CONVERT(varchar(max), (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO)), 6), (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO), 'Crayones de cera', 'Caja de 12 crayones de cera', (SELECT TOP 1 IdCategoria FROM CATEGORIA WHERE Descripcion = 'Crayones')),
(RIGHT('000000' + CONVERT(varchar(max), (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO)), 6), (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO), 'Crayones de colores', 'Caja de 24 crayones de colores', (SELECT TOP 1 IdCategoria FROM CATEGORIA WHERE Descripcion = 'Crayones')),

-- Plumones
(RIGHT('000000' + CONVERT(varchar(max), (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO)), 6), (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO), 'Plumones de pizarra', 'Set de 4 plumones de pizarra', (SELECT TOP 1 IdCategoria FROM CATEGORIA WHERE Descripcion = 'Plumones')),
(RIGHT('000000' + CONVERT(varchar(max), (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO)), 6), (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO), 'Plumones de colores', 'Set de 12 plumones de colores', (SELECT TOP 1 IdCategoria FROM CATEGORIA WHERE Descripcion = 'Plumones')),

-- Mochilas
(RIGHT('000000' + CONVERT(varchar(max), (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO)), 6), (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO), 'Mochila escolar', 'Mochila con compartimentos múltiples', (SELECT TOP 1 IdCategoria FROM CATEGORIA WHERE Descripcion = 'Mochilas')),
(RIGHT('000000' + CONVERT(varchar(max), (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO)), 6), (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO), 'Mochila deportiva', 'Mochila resistente al agua', (SELECT TOP 1 IdCategoria FROM CATEGORIA WHERE Descripcion = 'Mochilas')),

-- Estuches
(RIGHT('000000' + CONVERT(varchar(max), (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO)), 6), (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO), 'Estuche grande', 'Estuche para lápices grande', (SELECT TOP 1 IdCategoria FROM CATEGORIA WHERE Descripcion = 'Estuches')),
(RIGHT('000000' + CONVERT(varchar(max), (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO)), 6), (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO), 'Estuche pequeño', 'Estuche para lápices pequeño', (SELECT TOP 1 IdCategoria FROM CATEGORIA WHERE Descripcion = 'Estuches')),

-- Libretas
(RIGHT('000000' + CONVERT(varchar(max), (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO)), 6), (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO), 'Libreta de notas', 'Libreta de notas tamaño A6', (SELECT TOP 1 IdCategoria FROM CATEGORIA WHERE Descripcion = 'Libretas')),
(RIGHT('000000' + CONVERT(varchar(max), (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO)), 6), (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO), 'Libreta de bocetos', 'Libreta de bocetos tamaño A4', (SELECT TOP 1 IdCategoria FROM CATEGORIA WHERE Descripcion = 'Libretas'));

go
Insert into cliente(tipodocumento,numerodocumento,nombre,direccion,telefono) values 
('DNI','34231223','Jose Perez','av. Test 123','12345342'),
('DNI','56567878','Maria Paz','av. Test 124','12345343'),
('DNI','78907878','Thalia Qui�on','av. Test 125','12345344'),
('DNI','56346767','Belem Madara','av. Test 126','12345345'),
('DNI','34234234','Teresa espinoza','av. Test 127','12345346'),
('DNI','67788978','Arturo Sanchez','av. Test 128','12345347'),
('DNI','34311232','Pere Calvo','av. Test 129','12345348'),
('DNI','23234545','Naima Prat','av. Test 130','12345349'),
('DNI','45234545','Nicole Barreiro','av. Test 131','12345350'),
('DNI','23231212','Iratxe Ahmed','av. Test 132','12345351'),
('DNI','67678990','Monserrat Ballester','av. Test 133','12345352'),
('DNI','45455666','Alfonsa Mendoza','av. Test 135','12345354'),
('DNI','65765888','Alex Ramon','av. Test 136','12345355'),
('DNI','89768677','Pablo Rosell','av. Test 137','12345356'),
('DNI','67676789','Sebastian Palomino','av. Test 138','12345357'),
('DNI','76867878','Hamza Grau','av. Test 139','12345358'),
('DNI','89934233','Faustino Romo','av. Test 140','12345359')

go

insert into PROVEEDOR(ruc,RazonSocial,Telefono,Correo,Direccion) values
('25689789654','PROVEEDOR LIBRERIA JARDIN','345234234','manzana@ma.com','av . las manzanas'),
('45623412312','PROVEEDOR LIBRERIA DUARTE','123123456','pera@pe.co','av. las peras')

