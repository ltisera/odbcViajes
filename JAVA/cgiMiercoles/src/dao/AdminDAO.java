package dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Scanner;

import dao.Conexion;

public class AdminDAO {
	Conexion conexionmysql = new Conexion();
	Connection connect = (Connection) conexionmysql.Conectar();
	
	
	public boolean loginAdmin(String ussr, String pass){
		boolean respuesta = false;
		try {
			Statement miStatement;
			miStatement = (Statement) connect.createStatement();
			ResultSet miResultset;
			String miQuery = "call loginAdmin(\""+ ussr +"\",\""+ pass +"\")";
			System.out.println("Query en ejecucion: " + miQuery);
			miResultset = miStatement.executeQuery(miQuery);
			//recorrer el resultado de la query
			if (miResultset.next() == true) {
				respuesta = miResultset.getBoolean(1);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return respuesta;
		
	}
	
	public boolean configMillas(float valor, float km){
		boolean respuesta = false;
		try {
			Statement miStatement;
			miStatement = (Statement) connect.createStatement();
			String miQuery = "call configurarMillas(\""+ valor +"\",\""+ km +"\")";
			System.out.println("Query en ejecucion: " + miQuery);
			miStatement.executeQuery(miQuery);
			respuesta = true;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return respuesta;
		
	}
}
