package test;

import dao.CancelacionDAO;
import datos.Cancelacion;

public class camiTest {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		CancelacionDAO cdao = new CancelacionDAO();
		for(Cancelacion c: cdao.traerCancelaciones("1","6","2019-10-09","2019-10-09")) {
			System.out.println(c.toString());
		}
	}
 
}
