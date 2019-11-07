
import sys, os

sys.path.append(r'D:\Users\LucasPC\eclipse-workspace\RCPMiercolesSR\ClientePy\ejnamespace')

sys.path.append(r"D:\Users\LucasPC\eclipse-workspace\RCPMiercolesSR\ClientePy")

from ejnamespace import serviciosRapido

from ejnamespace.ttypes import Ciudad, Pasajero, CiudadExc, PasajeroExc
 

from thrift import Thrift
from thrift.transport import TSocket
from thrift.transport import TTransport
from thrift.protocol import TBinaryProtocol


if __name__ == '__main__':
    os.system('CLS')
    print("Ingrese ip: ", end="")
    transport = TSocket.TSocket(input(), 9090)

    # Buffering is critical. Raw sockets are very slow
    transport = TTransport.TBufferedTransport(transport)

    # Wrap in a protocol
    protocol = TBinaryProtocol.TBinaryProtocol(transport)

    # Create a client to use the protocol encoder
    client = serviciosRapido.Client(protocol)

    # Connect!
    
    transport.open()

    salir = None
    while(salir != "7"):
        
        os.system('CLS')
        print("Elija una opcion")
        print("1) traer Ciudad")
        print("2) traer latitud")
        print("3) traer nombre")
        print("4) traer Ciudades")
        print("5) traer pasajero")
        print("6) traer pasajeros")
        print("7) salir")
        print("Elegi: ", end='')
        salir = input()
        if(salir == "1"):
            print("Ingrese el id de la ciudad: ", end='')
            idCiudad = input()
            try:
                print(client.traerCiudad(int(idCiudad)))
            except CiudadExc as e:
                print("Ocurrio un error: ", e)
            except ValueError as e:
                print("Error: ", e)
        elif(salir == "2"):
            print("Ingrese el id de la ciudad: ", end='')
            idCiudad = input()
            try:
                print(client.traerLatitud(int(idCiudad)))
            except CiudadExc as e:
                print("Ocurrio un error: ", e)
            except ValueError as e:
                print("Error: ", e)
        elif(salir == "3"):
            print("Ingrese el id de la ciudad: ", end='')
            idCiudad = input()
            try:
                print(client.traerNombre(int(idCiudad)))
            except CiudadExc as e:
                print("Ocurrio un error: ", e)
            except ValueError as e:
                print("Error: ", e)
        elif(salir == "4"):
            try:
                ciudades = client.traerCiudades()
                for c in ciudades:
                    print(c)
            except CiudadExc as e:
                print("Ocurrio un error: ", e)
            except ValueError as e:
                print("Error: ", e)
        elif(salir == "5"):
            print("Ingrese el DNI del pasajero: ", end='')
            idPasajero = input()
            try:
                print(client.traerPasajero(int(idPasajero)))
            except PasajeroExc as e:
                print("Ocurrio un error: ", e)
            except ValueError as e:
                print("Error: ", e)
        elif(salir == "6"):
            try:
                pasajeros = client.traerPasajeros()
                for p in pasajeros:
                    print(p)
            except CiudadExc as e:
                print("Ocurrio un error: ", e)
            except ValueError as e:
                print("Error: ", e)
        elif(salir == "7"):
            print("ADIO!!!")
            transport.close()
            pass
        else:
            print("La pifiaste mestro volve a intentar")
        os.system('pause')