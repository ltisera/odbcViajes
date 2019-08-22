import mysql.connector
from CONFIGS.configs import getConfigDB


#modo = 'produccion'
modo = 'desarrollo'


if __name__ == '__main__':
    print("Arranco")
    cbd = ConexionBD()
    try:
        connectionDict = getConfigDB()
        bd = mysql.connector.connect(**connectionDict)
        micur = bd.cursor()
        print("abrobd")
        consulta = """call altaPasajero(38978965,"Tomas","Perefdsaf","12","mam@dwq",999,"jaja12","calle falsa","argenchino")"""
        micur.execute(consulta)
        bd.commit()
        print("comiteo")
            
    except mysql.connector.errors.IntegrityError as e:
        valido = "Usuario Usuario Duplicado"

    finally:
        micur = bd.cursor()
        bd.close()
        print("cierro tremino acabo")
