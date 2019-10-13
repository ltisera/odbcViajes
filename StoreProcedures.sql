use odbcViajes;
delimiter //
DROP PROCEDURE IF EXISTS configurarMillas//
CREATE PROCEDURE configurarMillas(in precio float, in kilometro float)
BEGIN
	set SQL_SAFE_UPDATES = 0;
	update configmillas set configmillas.precioMilla = precio;
	update configmillas set configmillas.millaXKilometro = kilometro;
	
    set SQL_SAFE_UPDATES = 1;
END//

DROP PROCEDURE IF EXISTS altaPasajero//
CREATE PROCEDURE altaPasajero (in dni int, in nombre varchar(45), in apellido varchar(45), in telefono varchar(45), in email varchar(45), in millas float, in clave varchar(45), in direccion varchar(45), in nacionalidad varchar(45))
BEGIN
	insert into pasajero (dni, nombre, apellido, telefono, email, millas, clave, direccion, nacionalidad) 
    values(dni, nombre, apellido, telefono, email, millas, clave, direccion, nacionalidad);
END//

DROP PROCEDURE IF EXISTS updatePasajero//
CREATE PROCEDURE updatePasajero (in dni int, in nombre varchar(45), in apellido varchar(45), in telefono varchar(45), in email varchar(45), in millas float, in clave varchar(45), in direccion varchar(45), in nacionalidad varchar(45))
BEGIN
	update pasajero as p set p.nombre = nombre, p.apellido = apellido, p.telefono = telefono, p.email = email, p.clave = clave, p.direccion = p.direccion, p.nacionalidad = nacionalidad
    where p.dni = dni;
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
CREATE PROCEDURE altaPasaje (in codigo varchar(10), in fecha date, out valor float, in pasajero int, in origen int, in destino int, in formaPago enum('dinero','millas'))
BEGIN
	declare millasDePasajero float;
	set codigo = null;
	call calcularValorPasaje(origen, destino, valor);
    call calcularCodigoPasaje(codigo);
	IF formaPago = "millas" then
		set millasDePasajero = (select MAX(configMillas.precioMilla) from configMillas) * (select pasajero.millas FROM pasajero where pasajero.DNI = pasajero); 
		if millasDePasajero > valor then
			call agregarPasaje(codigo, fecha, valor, pasajero, origen, destino, formaPago);
		else
			set codigo = "Err:Millas";
        end if;
	ELSE
		call agregarPasaje(codigo, fecha, valor, pasajero, origen, destino, formaPago);
	end IF;
    select codigo;
END//


DROP PROCEDURE IF EXISTS agregarPasaje//
CREATE PROCEDURE agregarPasaje (in codigo varchar(10), in fecha date, in valor float, in pasajero int, in origen int, in destino int, in formaPago enum('dinero','millas'))
BEGIN
	DECLARE clavePasajero varchar(45);
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
	declare dniPasajero int; 
	declare fechaPasaje datetime;
	declare yaFueCancelado int;
    declare reintegro float;
    declare monto float;
    declare millasPasaje float;
    
	select p.pasajero, p.fecha, p.cancelacion, p.valor, p.millas 
    into dniPasajero, fechaPasaje, yaFueCancelado, monto , millasPasaje
    from pasaje as p where p.codigo = codigo;
    
    if fechaPasaje is not null and fechaPasaje > NOW() then
		if yaFueCancelado is null then
			call calcularReintegro(fechaPasaje, monto, reintegro);
			insert into cancelacion (fecha, montoReintegro) values(NOW(), reintegro);
			update pasaje set pasaje.cancelacion = LAST_INSERT_ID() where pasaje.codigo = codigo;
            if millasPasaje is not null and (select clave from pasajero where pasajero.dni = dniPasajero) is not null then
				update pasajero as p set p.millas = p.millas - millasPasaje;
			end if;
            select reintegro;
		else
			select "ERR:El pasaje ya fue cancelado";
        end if;
	else
		select "ERR:La fecha del pasaje ya ha pasado";
	end if;
END//

DROP PROCEDURE IF EXISTS calcularReintegro//
CREATE PROCEDURE calcularReintegro(in fecha datetime, in monto float, out reintegro float)
BEGIN
	declare difEnDias float;
    set difEnDias = TIMESTAMPDIFF(DAY,now(),fecha);
    if  difEnDias <  1 then
		set reintegro =  0;
    elseif difEnDias <=  15 then
		set reintegro =  monto * ((3 * TIMESTAMPDIFF(DAY,now(),fecha)) / 100);
    elseif difEnDias <=  30 then
		set reintegro =  monto * 0.5;
	elseif difEnDias <=  60 then
		set reintegro =  monto * 0.7;
	else
		set reintegro =  monto * 0.9;
    end if;
    select reintegro;
END//

DROP PROCEDURE IF EXISTS consultaPasaje//
CREATE PROCEDURE consultaPasaje(in codigo varchar(10))
BEGIN
	SELECT P.codigo, P.fecha, P.valor, P.pasajero, cOrigen.nombre, cDestino.nombre, P.formaPago, P.cancelacion, P.millas 
    FROM pasaje as P 
    inner join Ciudad as cOrigen on cOrigen.idCiudad = P.origen 
    inner join Ciudad as cDestino on cDestino.idCiudad = P.destino 
    where P.codigo = codigo;
END//

DROP PROCEDURE IF EXISTS consultaPasajeXPasajero//
CREATE PROCEDURE consultaPasajeXPasajero(in DNI int)
BEGIN
	SELECT P.codigo, P.fecha, P.valor, P.pasajero, cOrigen.nombre, cDestino.nombre, P.formaPago, P.cancelacion, P.millas 
    FROM pasaje as P 
    inner join Ciudad as cOrigen on cOrigen.idCiudad = P.origen 
    inner join Ciudad as cDestino on cDestino.idCiudad = P.destino 
	where P.pasajero = DNI and P.cancelacion is null;
END//

DROP PROCEDURE IF EXISTS consultaPasajeXFiltro//
CREATE PROCEDURE consultaPasajeXFiltro(in DNI int, in codigo varchar(10), in origen int, in destino int, in desde date, in hasta date)
BEGIN
	SELECT P.codigo, P.fecha, P.valor, P.pasajero, cOrigen.nombre, cDestino.nombre, P.formaPago, P.cancelacion, P.millas 
    FROM pasaje as P 
    inner join Ciudad as cOrigen on cOrigen.idCiudad = P.origen 
    inner join Ciudad as cDestino on cDestino.idCiudad = P.destino
	where P.pasajero = DNI and P.cancelacion is null
    and P.codigo = IFNULL(codigo, P.codigo)
    and P.origen = IFNULL(origen, P.origen)
    and P.destino = IFNULL(destino, P.destino)
    and P.fecha >= IFNULL(desde, P.fecha)
    and P.fecha <= IFNULL(hasta, P.fecha);
END//

DROP PROCEDURE IF EXISTS altaCiudad//
CREATE PROCEDURE altaCiudad (in nombre varchar(45), in latitud varchar(45), in longitud varchar(45))
BEGIN
	insert into ciudad (nombre, latitud, longitud) 
    values(nombre, latitud, longitud);
END// 

DROP PROCEDURE IF EXISTS altaCiudadConBaja//
CREATE PROCEDURE altaCiudadConBaja (in idCiudad int)
BEGIN
	update ciudad set ciudad.baja = false where ciudad.idCiudad = idCiudad;
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

DROP PROCEDURE IF EXISTS consultaCiudadesConBaja//
CREATE PROCEDURE consultaCiudadesConBaja()
BEGIN
	SELECT * FROM ciudad where ciudad.baja = True;
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

DROP PROCEDURE IF EXISTS loginAdmin//
CREATE PROCEDURE loginAdmin(in usuario varchar(45), in clave varchar(45))
BEGIN
	DECLARE id int;
    SET id = (SELECT a.idAdmin from odbcviajes.admin as a where a.usuario = usuario and a.clave = clave);
    IF id IS NOT NULL THEN 
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