from DAO.pasaje import Pasaje
import mysql.connector
from DAO.ConexionBD import ConexionBD


class PasajeDAO(ConexionBD):
    def __init__(self):
        pass

    def agregarPasaje(self, pasaje):
        valido = False
        try:
            self.crearConexion()
            self._micur.callproc("altaPasaje", pasaje.datos())
            self._bd.commit()
            valido = True

        except mysql.connector.errors.IntegrityError as e:
            print(e)

        finally:
            self.cerrarConexion()

        return valido

    def cancelarPasaje(self, codigo):
        valido = False
        try:
            self.crearConexion()
            self._micur.callproc("cancelarPasaje", (codigo,))
            self._bd.commit()
            valido = True

        except mysql.connector.errors.IntegrityError as e:
            print(e)

        finally:
            self.cerrarConexion()

        return valido

    def traerPasaje(self, codigo):
        pTraido = None
        try:
            self.crearConexion()
            self._micur.callproc("consultaPasaje", (codigo,))
            for res in self._micur.stored_results():
                r = res.fetchone()
                if(r is not None):
                    pTraido = Pasaje(registro=r)

        except mysql.connector.Error as err:
            print("DANGER ALGO OCURRIO: " + str(err))
        finally:
            self.cerrarConexion()

        return pTraido

    def traerPasajesXPasajero(self, idPasajero):
        lstPasajes = []
        try:
            self.crearConexion()
            self._micur.callproc("consultaPasajeXPasajero", (idPasajero,))
            for result in self._micur.stored_results():
                reg = result.fetchall()
                if reg is not None:
                    for r in reg:
                        lstPasajes.append(Pasaje(registro=r))

        except mysql.connector.Error as err:
            print("DANGER ALGO OCURRIO: " + str(err))
        finally:
            self.cerrarConexion()
        return lstPasajes

    def traerPasajesXFiltro(self, dni, codigo, origen, destino, desde, hasta):
        lstPasajes = []
        try:
            self.crearConexion()
            self._micur.callproc("consultaPasajeXFiltro", (dni, codigo, origen, destino, desde, hasta,))
            for result in self._micur.stored_results():
                reg = result.fetchall()
                if reg is not None:
                    for r in reg:
                        lstPasajes.append(Pasaje(registro=r))

        except mysql.connector.Error as err:
            print("DANGER ALGO OCURRIO: " + str(err))
        finally:
            self.cerrarConexion()
        return lstPasajes

    def calcular(self, idCorigen, idCDestino, funcion):
        dato = ""
        try:
            self.crearConexion()
            self._micur.callproc(funcion, (idCorigen, idCDestino, dato))
            for result in self._micur.stored_results():
                dato = result.fetchone()[0]
        except mysql.connector.Error as err:
            print("DANGER ALGO OCURRIO: " + str(err))
        finally:
            self.crearConexion()
        return dato


if __name__ == '__main__':
    tstPDAO = PasajeDAO()
    tpasaje = Pasaje()
    print("ta")
    tpasaje.codigo = "1"
    print("ta")
    tpasaje.fecha = "2019-06-15"
    tpasaje.valor = 12.5
    tpasaje.pasajero = 3
    tpasaje.origen = 23
    tpasaje.destino = 12
    tpasaje.formaPago = "dinero"
    print("Mi pasaje")
    print(tpasaje.datos())
    print("PERSIS")
    tstPDAO.agregarPasaje(tpasaje)
    print("Vamo")
    