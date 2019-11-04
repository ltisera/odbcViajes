package handler;

import java.util.ArrayList;
import java.util.List;

import javax.lang.model.type.NullType;

import org.apache.thrift.TException;

import DAO.CiudadDAO;
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
    	CiudadDAO cDao = new CiudadDAO();
		
		c=cDao.traerCiudad(idCiudad);
		if(c == null) {
			throw new CiudadExc(1, "ciudad no encontrada");
		}
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

