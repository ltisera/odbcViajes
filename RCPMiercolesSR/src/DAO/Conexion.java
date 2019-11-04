package DAO;

import java.sql.Connection;
import java.sql.DriverManager;

public class Conexion {
	

	public Connection Conectar()
	{
	   
	  Connection conexion = null;
	   
	    try
	    {
	    	Class.forName("com.mysql.jdbc.Driver");
	    	conexion = DriverManager.getConnection("jdbc:mysql://127.0.0.1/odbcviajes","adminODBC","1234");
	    	System.out.println("SIIII conecta");
	    }
	    catch (Exception e)
	    {
	    	System.out.println("No conecta");
			e.printStackTrace();
	    }
	   
	    
	    return conexion;
	   
	}
	
	
	
	

}
