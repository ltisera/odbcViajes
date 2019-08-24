from pasajero import Pasajero
import mysql.connector
from mysql.connector import Error
from ConexionBD import ConexionBD

class PasajeroDAO(ConexionBD):
    def __init__(self):
        pass

    def agregarPasajero(self, pasajero):
        """Agrega un usuario, validando que el mail contenga "@"
            :Parameters:
                -'pasajero': Pasajero que desea agregarse
            :Return:
                (valido, str):
                    -"valido":
                        True si se agrego a la BD
                        False si no se agrego

                    -"mensaje" :
                        un mensaje de por que no se pudo agregar
            TO-DO: -Corregir mensajes de devolucion
        """
        valido = False
        try:
            self.crearConexion()
            mailValido = False
            for i in pasajero.email:
                if(i == "@"):
                    mailValido = True
            if(mailValido is True):
                self._micur.callproc("altaPasajero", pasajero.datos())
                self._bd.commit()
                valido = True
            else:
                valido = "No lo se rick, parece falso"

        except mysql.connector.errors.IntegrityError as e:
            
            valido = "Usuario Usuario Duplicado" + str(e)

        finally:

            self.cerrarConexion()

        return valido
    
    def traerPasajero(self, DNI):
        try:
            self.crearConexion()
            self._micur.callproc("consultaPasajero", (DNI,))
            for result in self._micur.stored_results():
                return result.fetchone()
                
        except mysql.connector.Error as err:
            print("DANGER ALGO OCURRIO: " + str (err))
        finally:
            self.cerrarConexion()
    
    def traerPasajerosXMail(self, mail):
        try:
            self.crearConexion()
            self._micur.callproc("consultaPasajeroXMail", (mail,))
            for result in self._micur.stored_results():
                return result.fetchone()
                
        except mysql.connector.Error as err:
            print("DANGER ALGO OCURRIO: " + str (err))
        finally:
            self.cerrarConexion()
    
    
if __name__ == '__main__':
    tstPDAO = PasajeroDAO()
    print(tstPDAO.traerPasajero(23))