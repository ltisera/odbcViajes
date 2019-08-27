delimiter //

#DROP PROCEDURE altaPasajero;
CREATE PROCEDURE altaPasajero (in dni int, in nombre varchar(45), in apellido varchar(45), in telefono varchar(45), in email varchar(45), in millas float, in clave varchar(45), in direccion varchar(45), in nacionalidad varchar(45))
BEGIN
	insert into pasajero (dni,nombre,apellido,telefono,email,millas,clave,direccion,nacionalidad) 
    values(dni,nombre,apellido,telefono,email,millas,clave,direccion,nacionalidad);
END//

#DROP PROCEDURE consultaPasajero;
CREATE PROCEDURE consultaPasajero(in DNI int)
BEGIN
	SELECT * FROM pasajero where pasajero.DNI = DNI;
END//

#DROP PROCEDURE consultaPasajeroXEmail;
CREATE PROCEDURE consultaPasajeroXEmail(in email varchar(45))
BEGIN
	SELECT * FROM pasajero where pasajero.email = email;
END//

#DROP PROCEDURE altaPasaje;
CREATE PROCEDURE altaPasaje (in codigo varchar(10), in fecha date, in valor float , in pasajero int, in origen int, in destino int, in formaPago enum('dinero','millas'))
BEGIN
	insert into pasaje (codigo, fecha, valor,  pasajero, origen,destino, formaPago) 
    values(codigo, fecha, valor,  pasajero, origen,destino, formaPago);
END//

#DROP PROCEDURE consultaPasaje;
CREATE PROCEDURE consultaPasaje(in codigo varchar(10))
BEGIN
	SELECT * FROM pasaje where pasaje.codigo = codigo;
END//

#DROP PROCEDURE consultaPasajeXPasajero;
CREATE PROCEDURE consultaPasajeXPasajero(in DNI int)
BEGIN
	SELECT * FROM pasaje where pasaje.pasajero = DNI;
END//

#DROP PROCEDURE altaCiudad;
CREATE PROCEDURE altaCiudad (in idDestinos int, in nombre varchar(45), in cordenada varchar(45) , in baja tinyint)
BEGIN
	insert into ciudad (idDestinos, nombre, cordenada, baja) 
    values(idDestinos, nombre, cordenada, baja);
END// 

#DROP PROCEDURE bajaCiudad;
CREATE PROCEDURE bajaCiudad (in idDestinos int)
BEGIN
	update ciudad set ciudad.baja = True where ciudad.idDestinos = idDestinos;
END//    

#DROP PROCEDURE consultaCiudad;
CREATE PROCEDURE consultaCiudad(in idDestinos int)
BEGIN
	SELECT * FROM ciudad where ciudad.idDestinos = idDestinos;
END//

#DROP PROCEDURE consultaCiudades;
CREATE PROCEDURE consultaCiudades()
BEGIN
	SELECT * FROM ciudad where ciudad.baja = False;
END//

delimiter ;


