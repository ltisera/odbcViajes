use odbcViajes;
delimiter //
DROP PROCEDURE IF EXISTS consultaPasajeros//
CREATE PROCEDURE consultaPasajeros()
BEGIN
	select * from pasajero;
END//
