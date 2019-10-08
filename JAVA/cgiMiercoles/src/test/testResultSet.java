package test;
import dao.AdminDAO;
public class testResultSet {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		AdminDAO adao = new AdminDAO(); 
		System.out.println(adao.loginAdmin("lucas", "1234"));
	}

}
