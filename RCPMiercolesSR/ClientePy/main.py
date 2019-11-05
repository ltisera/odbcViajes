
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

    transport = TSocket.TSocket('localhost', 9090)

    # Buffering is critical. Raw sockets are very slow
    transport = TTransport.TBufferedTransport(transport)

    # Wrap in a protocol
    protocol = TBinaryProtocol.TBinaryProtocol(transport)

    # Create a client to use the protocol encoder
    client = serviciosRapido.Client(protocol)

    # Connect!
    
    transport.open()

    print("soy main")
    salir = None
    while(salir != "7"):
        
        os.system('CLS')
        print("salir: ", salir)
        print("Elija una ocion")
        print("1) traer Ciudad")
        print("2) traer latitud")
        print("3) traer longitud")
        print("4) traer Ciudades")
        print("5) traer pasaje")
        print("6) traer pasajes")
        print("7) salir")
        print("Elegi: ", end='')
        salir = input()
        if(salir == "1"):
            print("Ingrese el id de la ciudad: ", end='')
            idCiudad = input()
            try:
                print(client.traerCiudad(int(idCiudad)))
            except CiudadExc as e:
                print("LA EX: ", e)
        elif(salir == "2"):
            print("2) traer latitud")
        elif(salir == "3"):
            print("3) traer longitud")
        elif(salir == "4"):
            print("4) traer Ciudades")
        elif(salir == "5"):
            print("5) traer pasaje")
        elif(salir == "6"):
            print("6) traer pasajes")
        elif(salir == "7"):
            print("ADIO!!!")
            transport.close()
            pass
        else:
            print("La pifiaste mestro volve a intentar")
        os.system('pause')