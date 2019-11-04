package DAO;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import DAO.Conexion;
import datos.Ciudad;

public class CiudadDAO {
	Conexion conexionmysql = new Conexion();
	Connection connect = (Connection) conexionmysql.Conectar();
	
	public List<Ciudad> traerCiudades(){
		List<Ciudad> ciudades = new ArrayList<Ciudad>();
		try {
			Statement miStatement;
			miStatement = (Statement) connect.createStatement();
			ResultSet rSet;
			String miQuery = "call consultaTodasLasCiudades()";
			System.out.println("Query en ejecucion: " + miQuery);
			rSet = miStatement.executeQuery(miQuery);
			//recorrer el resultado de la query
			while (rSet.next() == true) {
				ciudades.add(new Ciudad(rSet.getInt(1), rSet.getString(2), rSet.getString(3), rSet.getString(4), rSet.getBoolean(5)));
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return ciudades;
	}
	
	public Ciudad traerCiudad (int idCiudad) {
		Ciudad c = null;
		try {
			Statement miStatement;
			miStatement = (Statement) connect.createStatement();
			ResultSet rSet;
			String miQuery = "call consultaCiudad(\""+ idCiudad +"\")";
			System.out.println("Query en ejecucion: " + miQuery);
			rSet = miStatement.executeQuery(miQuery);
			//recorrer el resultado de la query
			if (rSet.next() == true) {
				c = new Ciudad(rSet.getInt(1), rSet.getString(2), rSet.getString(3), rSet.getString(4), rSet.getBoolean(5));
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return c;
	}
}
