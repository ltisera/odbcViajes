delimiter //
#DROP PROCEDURE `odbcviajes`.`altaPasajero`;

CREATE PROCEDURE altaPasajero (in dni int, in nombre varchar(45), in apellido varchar(45), in telefono varchar(45), in email varchar(45), in millas float, in clave varchar(45), in direccion varchar(45), in nacionalidad varchar(45))
BEGIN
	insert into pasajero (dni,nombre,apellido,telefono,email,millas,clave,direccion,nacionalidad) 
    values(dni,nombre,apellido,telefono,email,millas,clave,direccion,nacionalidad);
END//

#DROP PROCEDURE `odbcviajes`.`consultaPasajero`;
CREATE PROCEDURE consultaPasajero(in DNI int)
BEGIN
	SELECT * FROM pasajero where pasajero.DNI = DNI;
END//

create procedure pasajeroValido(in dni int, in clave varchar(45), out valido tinyint(1))
BEGIN
	declare pasa varchar(45);
	SELECT email INTO pasa FROM pasajero where pasajero.DNI = dni AND pasajero.clave = clave;
	if(pasa is not null) then
		SET valido = TRUE;
	else
		set valido = FALSE;
	end if;
END//
delimiter ;


