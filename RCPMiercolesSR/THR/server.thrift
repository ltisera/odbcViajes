namespace java ejnamespace
namespace py ejnamespace

struct Ciudad{
    1: i32 idCiudad;
    2: string nombre;
    3: string latitud;
    4: string longitud;
    5: bool baja;
}

struct Pasajero{
    1: i32 DNI;
    2: string nombre;
    3: string apellido;
    4: string telfono;
    5: string email;
    6: double millas;
    7: string clave;
    8: string direccion;
    9: string nacionalidad;

}

exception CiudadExc{
    1: i32 errorCode,
    2: string errorDetalle,
}

exception PasajeroExc{
    1: i32 errorCode,
    2: string errorDetalle,
}

service serviciosRapido{
    //Devuelve tipo primitivo
    string traerNombre (1: i32 idCiudad)
        throws(1: CiudadExc ce),
    string traerLatitud (1: i32 idCiudad)
        throws(1: CiudadExc ce),
    
    
    //Devuelve Entidad
    Ciudad traerCiudad (1: i32 idCiudad)
        throws(1: CiudadExc ce),

    Pasajero traerPasajero (1: i32 DNI)
        throws(1: PasajeroExc pe),
    
    //Devuelve Lista entidades
    list<Ciudad> traerCiudades(),
    list<Pasajero> traerPasajeros(),
    
}