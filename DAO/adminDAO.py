import mysql.connector
from mysql.connector import Error
from ConexionBD import ConexionBD


class AdminDAO(ConexionBD):
    def __init__(self):
        pass

    def resetearDB(self):
        valido = False
        try:
            self.crearConexion()
            self._micur.callproc("matarTodo")
            valido = True

        except mysql.connector.errors.IntegrityError as e:
            print(e)

        finally:
            self.cerrarConexion()

        return valido

    
if __name__ == '__main__':
    aDAO = AdminDAO()
    aDAO.resetearDB()
    print("Exito")