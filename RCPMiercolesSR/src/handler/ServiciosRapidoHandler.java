package handler;

import java.util.ArrayList;
import java.util.List;
import org.apache.thrift.TException;

import DAO.CiudadDAO;
import DAO.PasajeroDAO;
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
    	CiudadDAO cDao = new CiudadDAO();
    	Ciudad c = cDao.traerCiudad(idCiudad);
		if(c == null)throw new CiudadExc(1, "ciudad no encontrada");
    	return c;
    }

    public Pasajero traerPasajero(int DNI) throws PasajeroExc, org.apache.thrift.TException{
    	PasajeroDAO pDao = new PasajeroDAO();
    	Pasajero p = pDao.traerPasajero(DNI);
    	if (p == null) throw new PasajeroExc(1, "Pasajero inexistente");
    	return p;
    }

    public java.util.List<Ciudad> traerCiudades() throws org.apache.thrift.TException{
    	CiudadDAO cDao = new CiudadDAO();
    	return cDao.traerCiudades();
    	
    }

    public java.util.List<Pasajero> traerPasajeros() throws org.apache.thrift.TException{
    	PasajeroDAO pDao = new PasajeroDAO();
    	return pDao.traerPasajeros();
    }

}

