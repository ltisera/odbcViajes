package test;

import dao.CancelacionDAO;
import datos.Cancelacion;

public class camiTest {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		CancelacionDAO cdao = new CancelacionDAO();
		
		System.out.println(cdao.traerCancelaciones(null,null));
		for(Cancelacion c: cdao.traerCancelaciones(null,null)) {
			System.out.println(c.toString());
		}
	}
 
}
