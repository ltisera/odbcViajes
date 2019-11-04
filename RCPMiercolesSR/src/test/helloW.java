package test;

import DAO.CiudadDAO;
import ejnamespace.CiudadExc;
import handler.ServiciosRapidoHandler;
public class helloW {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		System.out.println("HOLA JAVA");
		
		
		try {
			ServiciosRapidoHandler sHandler = new ServiciosRapidoHandler();
			System.out.println(sHandler.traerCiudad(1123));
			
		}
		catch (Exception e){
			System.out.println("NO LLEGA");
			System.out.println(e);
			
		}
		finally {
			System.out.println("Fin");
		}
		
	}

}
