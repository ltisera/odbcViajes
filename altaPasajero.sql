delimiter //
DROP PROCEDURE IF EXISTS `odbcviajes`.`altaPasajero`;

CREATE PROCEDURE altaPasajero (in dni int, in nombre varchar(45), in apellido varchar(45), in telefono varchar(45), in email varchar(45), in millas float, in clave varchar(45), in direccion varchar(45), in nacionalidad varchar(45))
BEGIN
	insert into pasajero (dni,nombre,apellido,telefono,email,millas,clave,direccion,nacionalidad) 
    values(dni,nombre,apellido,telefono,email,millas,clave,direccion,nacionalidad);
END//

DROP PROCEDURE IF EXISTS `odbcviajes`.`consultaPasajero`;
CREATE PROCEDURE consultaPasajero(in DNI int)
BEGIN
	SELECT * FROM pasajero where pasajero.DNI = DNI;
END//

DROP PROCEDURE IF EXISTS `odbcviajes`.`agregarPasajero`;
CREATE PROCEDURE altaPasaje (in codigo varchar(10), in fecha date, in valor float , in pasajero int, in origen int, in destino int, in formaPago enum('dinero','millas'))
BEGIN
	insert into pasajero (codigo, fecha, valor,  pasajero, origen,destino, formaPago) 
    values(codigo, fecha, valor,  pasajero, origen,destino, formaPago);
END//
delimiter ;


