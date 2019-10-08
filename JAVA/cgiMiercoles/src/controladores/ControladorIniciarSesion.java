package controladores;


import java.io.PrintWriter;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import dao.AdminDAO;
/**
 * Servlet implementation class ControladorIniciarSesion
 */
@WebServlet("/ControladorIniciarSesion")
public class ControladorIniciarSesion extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ControladorIniciarSesion() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		procesaSolicitud(request, response);
	}
	
	protected void procesaSolicitud(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		String user =request.getParameter("usuario");
		String pass =request.getParameter("pass");
	
		AdminDAO adao = new AdminDAO(); 
		boolean u = adao.loginAdmin(user, pass);
		System.out.println("Boolean: " + u);
		response.setContentType("application/json");
		String salidaJson="{";
		
		if(u==true) {

			System.out.println("u == true");
			PrintWriter salida = response.getWriter();
			salidaJson += "\"logueado\":" + "\"" + u + "\"" + "}";
			salida.println(salidaJson);
			
			response.setStatus(200);//Usuario y contraseña correctos
		}
		else {

			System.out.println("Error");
			response.setStatus(500);//Usuario y/o contraseña incorrectos
		}
	}

}
