package controladores;


import java.io.PrintWriter;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import dao.AdminDAO;

@WebServlet("/ControladorConfigMillas")
public class ControladorConfigMillas extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public ControladorConfigMillas() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		procesaSolicitud(request, response);
	}
	
	protected void procesaSolicitud(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		String valor = request.getParameter("valor");
		String km = request.getParameter("km");
	
		AdminDAO adao = new AdminDAO(); 
		boolean u = adao.configMillas(Float.parseFloat(valor), Float.parseFloat(km));
		response.setContentType("application/json");
		if(u==true) {
			response.setStatus(200);//Millas modificadas
		}
		else {
			System.out.println("Error");
			response.setStatus(500);//Error
		}
	}

}
