import sys
#sys.path.append('D:\DropBox\Dropbox\FAcultad\Sistemas Distribuidos\odbcViajes\odbcViajes')
sys.path.append(r'C:\Users\Camila\Documents\GitHub\odbcViajes')
from DAO.pasajeroDAO import PasajeroDAO
from DAO.pasajero import Pasajero
from DAO.pasajeDAO import PasajeDAO
from DAO.ciudadDAO import CiudadDAO
from DAO.cancelacionDAO import CancelacionDAO
from flask import Flask, render_template, send_from_directory, request, jsonify, Response


app = Flask(__name__, static_folder='static', static_url_path='')

pasajeroDAO = PasajeroDAO()
ciudadDAO = CiudadDAO()
pasajeDAO = PasajeDAO()


@app.route('/', methods=['GET', 'POST'])
def index():
    return render_template('index.html')


@app.route('/registrar', methods=['GET', 'POST'])
def registrar():
    pasajero = Pasajero(request.values["dni"],
                 request.values["nombre"],
                 request.values["apellido"],
                 request.values["telefono"],
                 request.values["email"],
                 0, #millas 
                 request.values["password"],
                 request.values["direccion"],
                 request.values["nacionalidad"])
    print(pasajero)
    pasajeroDAO.agregarPasajero(pasajero)
    return jsonify((200))


@app.route('/login', methods=['GET', 'POST'])
def login():
    pasajero = pasajeroDAO.loginPasajero(request.values["dni"], request.values["clave"])
    print(pasajero)
    return jsonify((200, pasajero))


@app.route('/traerCiudades', methods=['GET', 'POST'])
def traerCiudades():
    lista = ciudadDAO.traerCiudades()
    lstRefJson = []
    for i in lista:
        if(len(lista) > 0):
            refJson = {}
            refJson["idCiudad"] = i.idCiudad
            refJson["nombre"] = i.nombre
            refJson["latitud"] = i.latitud
            refJson["longitud"] = i.longitud
            refJson["baja"] = i.baja

            lstRefJson.append(refJson)
    return jsonify((200, lstRefJson))


@app.route('/consulta', methods=['GET', 'POST'])
def consulta():
    return render_template('consulta.html')


@app.route('/traerPasaje', methods=['GET', 'POST'])
def traerPasaje():
    p = pasajeDAO.traerPasaje(request.values["codigo"])
    print(p)
    if p is not None:
        p = (p.codigo, p.fecha, p.valor, p.pasajero, p.origen, p.destino, p.formaPago, p.cancelacion)
    return jsonify((200, p))


@app.route('/traerPasajes', methods=['GET', 'POST'])
def traerPasajes():
    print(request.values["dni"])
    r = pasajeDAO.traerPasajesXPasajero(request.values["dni"])
    print(r)
    lstP = []
    for p in r:
        lstP.append((p.codigo, p.fecha, p.valor, p.pasajero, p.origen, p.destino, p.formaPago))
    return jsonify((200, lstP))


@app.route('/cancelarPasaje', methods=['GET', 'POST'])
def cancelarPasaje():
    pasajeDAO.cancelarPasaje(request.values["codigo"])
    print("hola")
    return jsonify((200))


@app.route('/pasajes', methods=['GET', 'POST'])
def pasajes():
    return render_template('pasajes.html')


@app.route('/buscarPasajes', methods=['GET', 'POST'])
def buscarPasajes():
    print(request)
    codigo = None
    origen = None
    destino = None
    desde = None
    hasta = None
    if(request.values["codigo"] != ""):
        codigo = request.values["codigo"]
    if(request.values["origen"] != "Seleccionar"):
        origen = request.values["origen"]
    if(request.values["destino"] != "Seleccionar"):
        destino = request.values["destino"]
    if(request.values["desde"] != ""):
        desde = request.values["desde"]
    if(request.values["hasta"] != ""):
        hasta = request.values["hasta"]
    r = pasajeDAO.traerPasajesXFiltro(request.values["dni"], codigo, origen, destino, desde, hasta)
    print(r)
    lstP = []
    for p in r:
        lstP.append((p.codigo, p.fecha, p.valor, p.pasajero, p.origen, p.destino, p.formaPago))
    return jsonify(lstP), 200


@app.route('/seleccionarViaje', methods=['GET', 'POST'])
def seleccionarViaje():
    idCOrigen = request.values["idCiudadOrigen"]
    idCDestino = request.values["idCiudadDestino"]
    print("Origen: " + idCOrigen + " Destino: " + idCDestino)
    if(idCOrigen != idCDestino):
        dicPasaje = {}
        dicPasaje["km"] = pasajeDAO.calcular(idCOrigen,idCDestino, "calcularDistancia")
        dicPasaje["valor"] = pasajeDAO.calcular(idCOrigen,idCDestino, "calcularValorPasaje")
        dicPasaje["millas"] = pasajeDAO.calcular(idCOrigen,idCDestino, "calcularMillas")
        return jsonify(dicPasaje), 200
    return jsonify("No se puede elegir el mismo destino que el origen"), 21


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
