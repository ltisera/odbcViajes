from pasaje import Pasaje
import mysql.connector
from mysql.connector import Error
from ConexionBD import ConexionBD

class PasajeDAO(ConexionBD):
    def __init__(self):
        pass

    def agregarPasaje(self, pasaje):
        valido = False
        try:
            self.crearConexion()
            print("TST")
            self._micur.callproc("altaPasaje",pasaje.datos())

            self._bd.commit()
            valido = True
            
        except mysql.connector.errors.IntegrityError as e:
            print(e)
            
        finally:


            self.cerrarConexion()

        return valido
    
    def traerPasaje(self, DNI):
        try:
            pTraido = None
            self.crearConexion()
            self._micur.callproc("consultaPasaje", (DNI,))
            for res in self._micur.stored_results():
                r = res.fetchone()
                if(r is not None):
                    pTraido = Pasaje(registro = r)
            return pTraido

        except mysql.connector.Error as err:
            print("DANGER ALGO OCURRIO: " + str (err))
        finally:
            self.cerrarConexion()
    
    def traerPasajesXMail(self, mail):
        try:
            self.crearConexion()
            self._micur.callproc("consultaPasajeXMail", (mail,))
            for result in self._micur.stored_results():
                return result.fetchone()
                
        except mysql.connector.Error as err:
            print("DANGER ALGO OCURRIO: " + str (err))
        finally:
            self.cerrarConexion()
    def loginPasaje(self, dni, clave):
        try:
            if (self.traerPasaje(dni).clave == clave):
                print("Pasaje registrado")
                return True
            else:
                return False
        except AttributeError as e:
            print ("Excep " + str(e))
            return False

"""
    Implementar el metodo Mathov    
    def loginPasaje(dni, mail = "", clave):
        self.traerPasaje(dni)
"""


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
    