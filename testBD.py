import mysql.connector



#modo = 'produccion'
modo = 'desarrollo'


def getConfigDB():
    configDB = {}
    if (modo == 'desarrollo'):
        configDB['host'] = 'localhost'
        configDB['user'] = 'root'
        configDB['password'] = 'root'
        configDB['database'] = 'mydb'
        configDB['auth_plugin']='mysql_native_password'

    elif(modo == 'produccion'):
        configDB['host'] = 'grcunla.mysql.pythonanywhere-services.com'
        configDB['user'] = 'grcunla'
        configDB['password'] = 'mmyt1234'
        configDB['database'] = 'grcunla$grcdb'
    else:
        configDB['host'] = None
        configDB['user'] = None
        configDB['password'] = None
        configDB['database'] = None

    return configDB



if __name__ == '__main__':
    print("Arranco")
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
