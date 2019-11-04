package handler;

import java.util.ArrayList;
import java.util.List;
import org.apache.thrift.TException;

import ejnamespace.Ciudad;
import ejnamespace.CiudadExc;
import ejnamespace.Pasajero;
import ejnamespace.PasajeroExc;
import ejnamespace.serviciosRapido.Iface;

public class ServiciosRapidoHandler implements Iface {

	public java.lang.String traerNombre(int idCiudad) throws CiudadExc, org.apache.thrift.TException{
		return "";
	}

    public java.lang.String traerLatitud(int idCiudad) throws CiudadExc, org.apache.thrift.TException{
    	return "";
    }

    public Ciudad traerCiudad(int idCiudad) throws CiudadExc, org.apache.thrift.TException{
    	Ciudad c = new Ciudad();
    	return c;
    }

    public Pasajero traerPasajero(int DNI) throws PasajeroExc, org.apache.thrift.TException{
    	Pasajero p = new Pasajero();
    	return p;
    }

    public java.util.List<Ciudad> traerCiudades() throws org.apache.thrift.TException{
    	List<Ciudad> l = new ArrayList<Ciudad>();
    	return l;
    	
    }

    public java.util.List<Pasajero> traerPasajeros() throws org.apache.thrift.TException{
    	List<Pasajero> p = new ArrayList<Pasajero>();
    	return p;
    }

}

