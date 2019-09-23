import sys
#sys.path.append('D:\DropBox\Dropbox\FAcultad\Sistemas Distribuidos\odbcViajes\odbcViajes')
sys.path.append(r'C:\Users\Camila\Documents\GitHub\odbcViajes')
from DAO.pasajeroDAO import PasajeroDAO
from DAO.ciudadDAO import CiudadDAO
from flask import Flask, render_template, send_from_directory, request, jsonify, Response


app = Flask(__name__, static_folder='static', static_url_path='')

pDAO = PasajeroDAO()


@app.route('/', methods=['GET', 'POST'])
def index():
    return render_template('index.html')


@app.route('/login', methods=['GET', 'POST'])
def login():
    pasajero = pDAO.loginPasajero(request.values["dni"], request.values["clave"])
    print(pasajero)
    return jsonify((200, pasajero))


@app.route('/traerCiudades', methods=['GET', 'POST'])
def traerCiudades():
    cDAO = CiudadDAO()
    lista = cDAO.traerCiudades()
    
    lstRefJson = []
    for i in lista:
        if(len(lista)>0):
            refJson = {}
            refJson["idCiudad"] = i.idCiudad
            refJson["nombre"] = i.nombre
            refJson["latitud"] = i.latitud
            refJson["longitud"] = i.longitud
            refJson["baja"] = i.baja

            lstRefJson.append(refJson)
    return jsonify((200, lstRefJson))


@app.route('/static/<path:path>')
def sirveDirectorioSTATIC(path):
    sPath = path.split("/")
    directorio = ""
    if(len(sPath) == 1):
        directorio = ""
        arc = sPath[len(sPath) - 1]
    else:
        for i in range(len(sPath) - 1):
            directorio = directorio + sPath[i] + "/"
        directorio = directorio[0:- 1]
        arc = sPath[len(sPath) - 1]
    directorio = "static/" + directorio
    return send_from_directory(directorio, arc)


app.run(debug=True)
