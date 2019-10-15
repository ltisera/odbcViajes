package dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.sql.Date;

import datos.Cancelacion;

public class CancelacionDAO {
	Conexion conexionmysql = new Conexion();
	Connection connect = (Connection) conexionmysql.Conectar();
	
	public List<Cancelacion> traerCancelaciones(Date fechaA, Date fechaB){
		List<Cancelacion> cancelacion = new ArrayList<Cancelacion>();
		try {
			Statement miStatement;
			miStatement = (Statement) connect.createStatement();
			ResultSet rSet;
			String miQuery = "call reporteCancelaciones(null,null,null,null)";
			System.out.println("Query en ejecucion: " + miQuery);
			rSet = miStatement.executeQuery(miQuery);
			//recorrer el resultado de la query
			while (rSet.next() == true) {
				cancelacion.add(new Cancelacion(rSet.getString(1), rSet.getString(5), rSet.getString(6), rSet.getDate(9), rSet.getFloat(10)));
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return cancelacion;
	}
}
