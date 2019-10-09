package dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

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
			String miQuery = "call consultaCiudades()";
			System.out.println("Query en ejecucion: " + miQuery);
			rSet = miStatement.executeQuery(miQuery);
			//recorrer el resultado de la query
			while (rSet.next() == true) {
				ciudades.add(new Ciudad(rSet.getInt(1), rSet.getString(2), rSet.getString(3), rSet.getString(4)));
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return ciudades;
		
	}
	public List<Ciudad> traerCiudadesConBaja(){
		List<Ciudad> ciudades = new ArrayList<Ciudad>();
		try {
			Statement miStatement;
			miStatement = (Statement) connect.createStatement();
			ResultSet rSet;
			String miQuery = "call consultaCiudadesConBaja()";
			System.out.println("Query en ejecucion: " + miQuery);
			rSet = miStatement.executeQuery(miQuery);
			//recorrer el resultado de la query
			while (rSet.next() == true) {
				ciudades.add(new Ciudad(rSet.getInt(1), rSet.getString(2), rSet.getString(3), rSet.getString(4)));
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return ciudades;
		
	}
	
	public int altaCiudad(String nombre, String latitud, String longitud){
		int idCiudad = -1;
		try {
			Statement miStatement;
			miStatement = (Statement) connect.createStatement();
			ResultSet rSet;
			String miQuery = "call altaCiudad(\""+ nombre +"\",\""+ latitud +"\",\""+ longitud +"\")";
			System.out.println("Query en ejecucion: " + miQuery);
			rSet = miStatement.executeQuery(miQuery);
			//recorrer el resultado de la query
			/*if (rSet.next() == true) {
				idCiudad = rSet.getInt(1);
			}*/
			idCiudad = 10;
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return idCiudad;
		
	}

}
