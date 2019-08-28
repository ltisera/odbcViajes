import sys
sys.path.append('D:\DropBox\Dropbox\FAcultad\Sistemas Distribuidos\odbcViajes\odbcViajes')
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
    # idCiudad, nombre, coordenada, baja
    print("\nAgregando ciudades... ", end='')
    lstC = []

    if ciudadDAO.traerCiudades() == []:
        lstC.append(Ciudad(nombre="Buenos Aires", coordenada="123321444"))
        lstC.append(Ciudad(nombre="Cordoba", coordenada="3476423794194"))
        lstC.append(Ciudad(nombre="Jujuy", coordenada="1231446828"))

        for c in lstC:
            ciudadDAO.agregarCiudad(c)

    print("Completado")


def agregarPasajes(pasajeDAO):
    # codigo, fecha, valor, pasajero, origen, destino, formaPago
    print("\nAgregando pasajes... ", end='')
    lstP = []

    lstP.append(Pasaje("1", None, 1000, 5, 1, 2, None))
    lstP.append(Pasaje("2", None, 1000, 5, 1, 2, None))
    lstP.append(Pasaje("3", None, 1000, 5, 1, 2, None))
    lstP.append(Pasaje("4", None, 1000, 1, 2, 3, None))

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
