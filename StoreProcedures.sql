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

DROP PROCEDURE IF EXISTS calcularDistancia//
CREATE PROCEDURE calcularDistancia (in origen int, in destino int, out distancia float)
BEGIN
	DECLARE latO varchar(45);
	DECLARE lonO varchar(45);
	DECLARE latD varchar(45);
	DECLARE lonD varchar(45);
	SELECT latO = latitud FROM ciudad where ciudad.idCiudad = origen;
	SELECT lonO = longitud FROM ciudad where ciudad.idCiudad = origen;
	SELECT latD = latitud FROM ciudad where ciudad.idCiudad = destino;
	SELECT lonD = longitud FROM ciudad where ciudad.idCiudad = destino;
	SET valor = SQRT(POW(latO-latD) + POW(lonO-lonD));
END//

DROP PROCEDURE IF EXISTS calcularMillas//
CREATE PROCEDURE calcularMillas (in origen int, in destino int, out millas float)
BEGIN
	SELECT millas = configMillas.precioMilla from configMillas;
	set millas = calcularDistancia(origen, destino) * millas;
END//

DROP PROCEDURE IF EXISTS calcularValorPasaje//
CREATE PROCEDURE calcularValorPasaje (in origen int, in destino int, out valor float)
BEGIN
	set valor = calcularDistancia(origen, destino);
END//

DROP PROCEDURE IF EXISTS altaPasaje//
CREATE PROCEDURE altaPasaje (in codigo varchar(10), in fecha date, in valor float, in pasajero int, in origen int, in destino int, in formaPago enum('dinero','millas'))
BEGIN
	declare millasDePasajero float;
	set valor = calcularValorPasaje(origen, destino);
	IF formaPago = "millas" then
		SELECT millasDePasajero = configMillas.precioMilla from configMillas;
		SELECT millasDePasajero = millasDePasajero * pasajero.millas FROM pasajero where pasajero.DNI = pasajero; 
		if millasDePasajero > valor then
			select agregarPasaje(codigo, fecha, valor, pasajero, origen, destino, formaPago);
		end if;
	ELSE
		select agregarPasaje(codigo, fecha, valor, pasajero, origen, destino, formaPago);
	end IF;
END//


DROP PROCEDURE IF EXISTS agregarPasaje//
CREATE PROCEDURE agregarPasaje (in codigo varchar(10), in fecha date, in valor float, in pasajero int, in origen int, in destino int, in formaPago enum('dinero','millas'))
BEGIN
	DECLARE clavePasajero INT;
	DECLARE millas float;
	insert into pasaje (codigo, fecha, valor, pasajero, origen, destino, formaPago) 
    values(codigo, fecha, valor, pasajero, origen, destino, formaPago);
	SET clavePasajero = (SELECT clave FROM pasajero where pasajero.DNI = DNI);
    IF clavePasajero is not null then
		set millas = calcularMillas(origen, destino);
		update pasajero set pasajero.millas = (pasajero.millas + millas) where pasajero.DNI = pasajero;
	end if;
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