package controladores;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import dao.CiudadDAO;

@WebServlet("/ControladorAltaCiudad")
public class ControladorBajaCiudad extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public ControladorBajaCiudad() {
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
		System.out.println(request.getParameter("id"));
		int id = Integer.parseInt(request.getParameter("id"));
	
		CiudadDAO cdao = new CiudadDAO(); 
		int u = cdao.bajaCiudad(id);
		//response.setContentType("application/json");
		if(u != -1) {
			response.setStatus(200);//Ciudad dada de Bajas
		}
		else {
			System.out.println("Error");
			response.setStatus(500);//Error
		}
	}

}
