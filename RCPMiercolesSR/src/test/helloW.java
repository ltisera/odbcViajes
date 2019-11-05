package test;

import ejnamespace.Pasajero;
import handler.ServiciosRapidoHandler;

public class helloW {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		System.out.println("HOLA JAVA");
		ServiciosRapidoHandler s =new ServiciosRapidoHandler();
		try {
			System.out.println(s.traerPasajero(300));
		}catch (Exception e){
			System.out.println(e);
		}
		System.out.println("--------------------------------------------");
		try {
			for(Pasajero p : s.traerPasajeros()) {
				System.out.println(p);
			}
		}catch (Exception e){
			System.out.println(e);
		}
	}

}
