import sys
import datetime
sys.path.append(r'D:\DropBox\Dropbox\FAcultad\Sistemas Distribuidos\odbcViajes\odbcViajes')
sys.path.append(r'C:\Users\Camila\Documents\GitHub\odbcViajes')
from DAO.pasajeroDAO import PasajeroDAO
from DAO.pasajero import Pasajero
from DAO.pasajeDAO import PasajeDAO
from DAO.pasaje import Pasaje
from DAO.ciudadDAO import CiudadDAO
from DAO.ciudad import Ciudad


def agregarPasajeros(pasajeroDAO):
    # DNI,nombre,apellido,telefono,email,millas,clave,direccion,nacionalidad
    print("\nAgregando pasajeros... ", end='')
    lstP = []

    # Casuales
    lstP.append(Pasajero(1, "Juancho", "Perez", "01115...", "algo1@gmail.com", None, None, "calle false 123", "arg"))
    lstP.append(Pasajero(2, "Armando", "Paredes", "01115...", "algo2@gmail.com", None, None, "calle false 123", "arg"))
    lstP.append(Pasajero(3, "Alvaro", "Martines", "01115...", "algo3@gmail.com", None, None, "calle false 123", "arg"))
    lstP.append(Pasajero(4, "Pepe", "Velasquez", "01115...", "algo4@gmail.com", None, None, "calle false 123", "arg"))

    # Regulares
    lstP.append(Pasajero(5, "Joaquin", "Gonzales", "01115...", "algo5@gmail.com", 10, "1234", "calle false 123", "arg"))
    lstP.append(Pasajero(6, "Martina", "Moreno", "01115...", "algo6@gmail.com", 20, "1234", "calle false 123", "arg"))
    lstP.append(Pasajero(7, "Karina", "Gomez", "01115...", "algo7@gmail.com", 30, "1234", "calle false 123", "arg"))
    lstP.append(Pasajero(8, "Leila", "Rodriguez", "01115...", "algo8@gmail.com", 50, "1234", "calle false 123", "arg"))

    for p in lstP:
        pasajeroDAO.agregarPasajero(p)

    print("Completado")


def agregarCiudades(ciudadDAO):
    # idCiudad, nombre, latitud, longitud, baja
    print("\nAgregando ciudades... ", end='')
    lstC = []

    if ciudadDAO.traerCiudades() == []:
        lstC.append(Ciudad(nombre="Buenos Aires",   latitud="-34.6131500", longitud="-58.3772300"))
        lstC.append(Ciudad(nombre="Cordoba",        latitud="-31.4135000", longitud="-64.1810500"))
        lstC.append(Ciudad(nombre="Jujuy",          latitud="-24.1945700", longitud="-65.2971200"))
        lstC.append(Ciudad(nombre="Rosario",        latitud="-60.6393200", longitud="-32.9468200"))
        lstC.append(Ciudad(nombre="Mendoza",        latitud="-68.8271700", longitud="-32.8908400"))
        lstC.append(Ciudad(nombre="Tucuman",        latitud="-65.2226000", longitud="-26.8241400"))
        lstC.append(Ciudad(nombre="La Plata",       latitud="-57.9545300", longitud="-34.9214500"))
        lstC.append(Ciudad(nombre="Mar del Plata",  latitud="-57.5575400", longitud="-38.0022800"))
        lstC.append(Ciudad(nombre="Quilmes",        latitud="-58.2526500", longitud="-34.7241800"))
        lstC.append(Ciudad(nombre="Arequito",       latitud="-33.1453000", longitud="-33.1453000"))
        lstC.append(Ciudad(nombre="Salta",          latitud="-65.4116600", longitud="-24.7859000"))
        lstC.append(Ciudad(nombre="Neuquen",        latitud="-68.0591000", longitud="-38.9516100"))

        for c in lstC:
            ciudadDAO.agregarCiudad(c)

    print("Completado")


def agregarPasajes(pasajeDAO):
    # codigo, fecha, valor, pasajero, origen, destino, formaPago, cancelacion
    print("\nAgregando pasajes... ", end='')
    lstP = []

    lstP.append(Pasaje("1", datetime.date(2019, 4, 13), 1000, 5, 1, 2, "dinero"))
    lstP.append(Pasaje("2", datetime.date(2019, 4, 13), 1000, 5, 1, 3, "dinero"))
    lstP.append(Pasaje("3", datetime.date(2019, 4, 13), 1000, 5, 2, 3, "dinero"))
    lstP.append(Pasaje("4", datetime.date(2019, 4, 20), 1000, 1, 2, 3, "dinero"))

    for p in lstP:
        pasajeDAO.agregarPasaje(p)

    print("Completado")


def tstPasajeroDAO(pasajeroDAO):
    print("\n---Cliente casual clave None---")
    print(pasajeroDAO.loginPasajero(1, None))
    print("\n---Cliente casual clave 1234---")
    print(pasajeroDAO.loginPasajero(1, 1234))

    p = pasajeroDAO.traerPasajero(5)
    print("\n---Cliente regular clave None---")
    print(pasajeroDAO.loginPasajero(5, None))
    print("\n---Cliente regular clave falsa---")
    print(pasajeroDAO.loginPasajero(5, "Mentiras"))
    print("\n---Cliente regular clave real---")
    print(pasajeroDAO.loginPasajero(5, p.clave))

    print("\n---Cliente inexistente clave None---")
    print(pasajeroDAO.loginPasajero(666, None))
    print("\n---Cliente inexistente clave 1234---")
    print(pasajeroDAO.loginPasajero(666, "1234"))


def tstPasajeDAO(pasajeDAO):
    print("\n---Pasaje nro 4---")
    print(pasajeDAO.traerPasaje(4))

    print("\n---Pasajes pasajero 5---")
    for p in pasajeDAO.traerPasajesXPasajero(5):
        print(p)


if __name__ == '__main__':
    print("Arranco")
    pasajeroDAO = PasajeroDAO()
    ciudadDAO = CiudadDAO()
    pasajeDAO = PasajeDAO()

    agregarPasajeros(pasajeroDAO)
    tstPasajeroDAO(pasajeroDAO)

    agregarCiudades(ciudadDAO)
    agregarPasajes(pasajeDAO)
    tstPasajeDAO(pasajeDAO)
