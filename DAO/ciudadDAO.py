from DAO.ciudad import Ciudad
import mysql.connector
from mysql.connector import Error
from DAO.ConexionBD import ConexionBD


class CiudadDAO(ConexionBD):
    def __init__(self):
        pass

    def agregarCiudad(self, ciudad):
        valido = False
        try:
            self.crearConexion()
            self._micur.callproc("altaCiudad", ciudad.datos())
            self._bd.commit()
            valido = True

        except mysql.connector.errors.IntegrityError as e:
            print(e)

        finally:
            self.cerrarConexion()

        return valido

    def eliminarCiudad(self, idCiudad):
        valido = False
        try:
            self.crearConexion()
            self._micur.callproc("bajaCiudad", (idCiudad,))
            self._bd.commit()
            valido = True

        except mysql.connector.Error as err:
            print("DANGER ALGO OCURRIO: " + str(err))

        finally:
            self.cerrarConexion()

        return valido

    def traerCiudad(self, idCiudad):
        cTraido = None
        try:
            self.crearConexion()
            self._micur.callproc("consultaCiudad", (idCiudad,))
            for res in self._micur.stored_results():
                r = res.fetchone()
                if(r is not None):
                    cTraido = Ciudad(registro=r)

        except mysql.connector.Error as err:
            print("DANGER ALGO OCURRIO: " + str(err))

        finally:
            self.cerrarConexion()

        return cTraido

    def traerCiudades(self):
        lstCiudades = []
        try:
            self.crearConexion()
            self._micur.callproc("consultaCiudades")
            for result in self._micur.stored_results():
                reg = result.fetchall()
                if reg is not None:
                    for r in reg:
                        lstCiudades.append(Ciudad(registro=r))
                else:
                    print("No hay ciudades")

        except mysql.connector.Error as err:
            print("DANGER ALGO OCURRIO: " + str(err))

        finally:
            self.cerrarConexion()

        return lstCiudades


if __name__ == '__main__':
    pass