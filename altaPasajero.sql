create procedure altaPasajero (in dni int, in nombre varchar(45), in apellido varchar(45), in telefono varchar(45), in email varchar(45), in millas float, in clave varchar(45), in direccion varchar(45), in nacionalidad varchar(45))
BEGIN
	insert into pasajero (dni,nombre,apellido,telefono,email,millas,clave,direccion,nacionalidad) 
    values(dni,nombre,apellido,telefono,email,millas,clave,direccion,nacionalidad);
END
