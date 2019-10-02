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
    
	SET latO = (SELECT latitud from ciudad where idCiudad = origen);
    SET lonO = (SELECT longitud from ciudad where idCiudad = origen);
    SET latD = (SELECT latitud from ciudad where idCiudad = destino);
    SET lonD = (SELECT longitud from ciudad where idCiudad = destino);
    
    SET distancia = SQRT(POW(latO-latD,2) + POW(lonO-lonD,2));
	select distancia;
END//

DROP PROCEDURE IF EXISTS calcularMillas//
CREATE PROCEDURE calcularMillas (in origen int, in destino int, out millas float)
BEGIN
	set @distancia = 0;
    call calcularDistancia(origen, destino, @distancia);
	set millas = @distancia * (SELECT MAX(configMillas.millaXKilometro) from configMillas);
    select millas;
END//

DROP PROCEDURE IF EXISTS calcularValorPasaje//
CREATE PROCEDURE calcularValorPasaje (in origen int, in destino int, out valor float)
BEGIN
	set @distancia = 0;
    call calcularDistancia(origen, destino, @distancia);
	set valor = @distancia * 1000;
    select valor;
END//

DROP PROCEDURE IF EXISTS calcularCodigoPasaje//
CREATE PROCEDURE calcularCodigoPasaje (out codigoNuevo varchar(10))
BEGIN
	set codigoNuevo = (SELECT substring(codigo,2) FROM pasaje WHERE substring(codigo,2)=(SELECT MAX(CAST(SUBSTRING(codigo,2) AS SIGNED)) FROM pasaje));
    if codigoNuevo is null then
		set codigoNuevo = CONCAT("C", LPAD(1, 9, "0"));
	else
		set codigoNuevo = CONCAT("C", LPAD((codigoNuevo + 1), 9, "0"));
	end if;
    select codigoNuevo;
END//

DROP PROCEDURE IF EXISTS altaPasaje//
CREATE PROCEDURE altaPasaje (out codigo varchar(10), in fecha date, out valor float, in pasajero int, in origen int, in destino int, in formaPago enum('dinero','millas'))
BEGIN
	declare millasDePasajero float;
	call calcularValorPasaje(origen, destino, valor);
    call calcularCodigoPasaje(codigo);
	IF formaPago = "millas" then
		set millasDePasajero = (select MAX(configMillas.precioMilla) from configMillas) * (select pasajero.millas FROM pasajero where pasajero.DNI = pasajero); 
		if millasDePasajero > valor then
			call agregarPasaje(codigo, fecha, valor, pasajero, origen, destino, formaPago);
		end if;
	ELSE
		call agregarPasaje(codigo, fecha, valor, pasajero, origen, destino, formaPago);
	end IF;
END//


DROP PROCEDURE IF EXISTS agregarPasaje//
CREATE PROCEDURE agregarPasaje (in codigo varchar(10), in fecha date, in valor float, in pasajero int, in origen int, in destino int, in formaPago enum('dinero','millas'))
BEGIN
	DECLARE clavePasajero INT;
	DECLARE millas float;
    set millas = null;
	SET clavePasajero = (SELECT pasajero.clave FROM pasajero where pasajero.DNI = pasajero);
    IF clavePasajero is not null then
		call calcularMillas(origen, destino, millas);
		update pasajero set pasajero.millas = (pasajero.millas + millas) where pasajero.DNI = pasajero;
	end if;
    insert into pasaje (codigo, fecha, valor, pasajero, origen, destino, formaPago, millas) 
    values(codigo, fecha, valor, pasajero, origen, destino, formaPago, millas);
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

DROP PROCEDURE IF EXISTS consultaPasajeXFiltro//
CREATE PROCEDURE consultaPasajeXFiltro(in DNI int, in codigo varchar(10), in origen int, in destino int, in desde date, in hasta date)
BEGIN
	SELECT * FROM pasaje where pasaje.pasajero = DNI and pasaje.cancelacion is null
    and pasaje.codigo = IFNULL(codigo, pasaje.codigo)
    and pasaje.origen = IFNULL(origen, pasaje.origen)
    and pasaje.destino = IFNULL(destino, pasaje.destino)
    and pasaje.fecha > IFNULL(desde, pasaje.fecha)
    and pasaje.fecha <= IFNULL(hasta, pasaje.fecha)
    ;
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