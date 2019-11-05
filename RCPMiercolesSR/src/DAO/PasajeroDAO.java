package DAO;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import DAO.Conexion;
import ejnamespace.Pasajero;

public class PasajeroDAO {
	Conexion conexionmysql = new Conexion();
	Connection connect = (Connection) conexionmysql.Conectar();
	
	public List<Pasajero> traerPasajeros(){
		List<Pasajero> lstP = new ArrayList<Pasajero>();
		try {
			Statement miStatement;
			miStatement = (Statement) connect.createStatement();
			ResultSet rSet;
			String miQuery = "call consultaPasajeros()";
			System.out.println("Query en ejecucion: " + miQuery);
			rSet = miStatement.executeQuery(miQuery);
			//recorrer el resultado de la query
			while (rSet.next() == true) {
				lstP.add(new Pasajero(rSet.getInt(1), rSet.getString(2), rSet.getString(3), rSet.getString(4), rSet.getString(5), rSet.getDouble(6), rSet.getString(7), rSet.getString(8), rSet.getString(9)));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return lstP;
	}
	
	public Pasajero traerPasajero (int dni) {
		Pasajero p = null;
		try {
			Statement miStatement;
			miStatement = (Statement) connect.createStatement();
			ResultSet rSet;
			String miQuery = "call consultaPasajero(\""+ dni +"\")";
			System.out.println("Query en ejecucion: " + miQuery);
			rSet = miStatement.executeQuery(miQuery);
			//recorrer el resultado de la query
			if (rSet.next() == true) {
				p = new Pasajero(rSet.getInt(1), rSet.getString(2), rSet.getString(3), rSet.getString(4), rSet.getString(5), rSet.getDouble(6), rSet.getString(7), rSet.getString(8), rSet.getString(9));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return p;
	}
}
