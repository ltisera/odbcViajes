use odbcViajes;
delimiter //
DROP PROCEDURE IF EXISTS altaPasajero//
CREATE PROCEDURE altaPasajero (in dni int, in nombre varchar(45), in apellido varchar(45), in telefono varchar(45), in email varchar(45), in millas float, in clave varchar(45), in direccion varchar(45), in nacionalidad varchar(45))
BEGIN
	insert into pasajero (dni, nombre, apellido, telefono, email, millas, clave, direccion, nacionalidad) 
    values(dni, nombre, apellido, telefono, email, millas, clave, direccion, nacionalidad);
END//

DROP PROCEDURE IF EXISTS consultaPasajero//
CREATE PROCEDURE consultaPasajero(in DNI int)
BEGIN
	SELECT * FROM pasajero where pasajero.DNI = DNI;
END//

DROP PROCEDURE IF EXISTS consultaPasajeroXEmail//
CREATE PROCEDURE consultaPasajeroXEmail(in email varchar(45))
BEGIN
	SELECT * FROM pasajero where pasajero.email = email;
END//

DROP PROCEDURE IF EXISTS altaPasaje//
CREATE PROCEDURE altaPasaje (in codigo varchar(10), in fecha date, in valor float, in pasajero int, in origen int, in destino int, in formaPago enum('dinero','millas'))
BEGIN
	insert into pasaje (codigo, fecha, valor, pasajero, origen, destino, formaPago) 
    values(codigo, fecha, valor, pasajero, origen, destino, formaPago);
END//

DROP PROCEDURE IF EXISTS cancelarPasaje//
CREATE PROCEDURE cancelarPasaje(in codigo varchar(10))
BEGIN
	insert into cancelacion (fecha, montoReintegro)
	values(NOW(), 1);
	update pasaje set pasaje.cancelacion = LAST_INSERT_ID() where pasaje.codigo = codigo;
END//

DROP PROCEDURE IF EXISTS consultaPasaje//
CREATE PROCEDURE consultaPasaje(in codigo varchar(10))
BEGIN
	SELECT * FROM pasaje where pasaje.codigo = codigo;
END//

DROP PROCEDURE IF EXISTS consultaPasajeXPasajero//
CREATE PROCEDURE consultaPasajeXPasajero(in DNI int)
BEGIN
	SELECT * FROM pasaje where pasaje.pasajero = DNI and pasaje.cancelacion is null;
END//

DROP PROCEDURE IF EXISTS altaCiudad//
CREATE PROCEDURE altaCiudad (in nombre varchar(45), in latitud varchar(45), in longitud varchar(45))
BEGIN
	insert into ciudad (nombre, latitud, longitud) 
    values(nombre, latitud, longitud);
END// 

DROP PROCEDURE IF EXISTS bajaCiudad//
CREATE PROCEDURE bajaCiudad (in idCiudad int)
BEGIN
	update ciudad set ciudad.baja = True where ciudad.idCiudad = idCiudad;
END//    

DROP PROCEDURE IF EXISTS consultaCiudad//
CREATE PROCEDURE consultaCiudad(in idDestinos int)
BEGIN
	SELECT * FROM ciudad where ciudad.idCiudad = idCiudad;
END//

DROP PROCEDURE IF EXISTS consultaCiudades//
CREATE PROCEDURE consultaCiudades()
BEGIN
	SELECT * FROM ciudad where ciudad.baja = False;
END//

DROP PROCEDURE IF EXISTS loginPasajero//
CREATE PROCEDURE loginPasajero(in DNI int, in clave varchar(45))
BEGIN
	DECLARE registro INT;
    SET registro = (SELECT DNI from Pasajero where pasajero.DNI = DNI and pasajero.clave = clave);
    IF registro IS NOT NULL THEN 
		SELECT TRUE;
    ELSE
		SELECT FALSE;
	end if;
END//

DROP PROCEDURE IF EXISTS matarTodo//
create procedure matarTodo()
begin
	set SQL_SAFE_UPDATES = 0;
	delete from pasaje;
    delete from cancelacion;
    
    delete from pasajero;
   
	delete from ciudad;
    ALTER TABLE ciudad AUTO_INCREMENT = 1;
    ALTER TABLE cancelacion AUTO_INCREMENT = 1;
    
    
    
    set SQL_SAFE_UPDATES = 1;
end//
delimiter ;


