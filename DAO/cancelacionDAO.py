from DAO.cancelacion import Cancelacion
import mysql.connector
from DAO.ConexionBD import ConexionBD


class CancelacionDAO(ConexionBD):
    def __init__(self):
        pass

    def agregarCancelacion(self, cancelacion):
        valido = False
        try:
            self.crearConexion()
            self._micur.callproc("altaCancelacion", cancelacion.datos())
            self._bd.commit()
            valido = True

        except mysql.connector.errors.IntegrityError as e:
            print(e)

        finally:
            self.cerrarConexion()

        return valido

    def traerCancelacion(self, codigo):
        pTraido = None
        try:
            self.crearConexion()
            self._micur.callproc("consultaCancelacion", (codigo,))
            for res in self._micur.stored_results():
                r = res.fetchone()
                if(r is not None):
                    pTraido = Cancelacion(registro=r)

        except mysql.connector.Error as err:
            print("DANGER ALGO OCURRIO: " + str(err))
        finally:
            self.cerrarConexion()

        return pTraido

    def traerCancelacionsXPasaje(self, idPasaje):
        pTraido = None
        try:
            self.crearConexion()
            self._micur.callproc("consultaCancelacionXPasaje", (idPasaje,))
            for result in self._micur.stored_results():
                r = result.fetchone()
                if(r is not None):
                    pTraido = Cancelacion(registro=r)

        except mysql.connector.Error as err:
            print("DANGER ALGO OCURRIO: " + str(err))
        finally:
            self.cerrarConexion()

        return pTraido


if __name__ == '__main__':
    pass
    