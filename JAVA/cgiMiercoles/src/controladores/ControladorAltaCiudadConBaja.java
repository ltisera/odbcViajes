package controladores;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import dao.CiudadDAO;

@WebServlet("/ControladorAltaCiudadConBaja")
public class ControladorAltaCiudadConBaja extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public ControladorAltaCiudadConBaja() {
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
		int id = Integer.parseInt(request.getParameter("id"));
	
		CiudadDAO cdao = new CiudadDAO(); 
		int u = cdao.altaCiudadConBaja(id);
		//response.setContentType("application/json");
		if(u != -1) {
			response.setStatus(200);//Ciudad dada de Alta
		}
		else {
			System.out.println("Error");
			response.setStatus(500);//Error
		}
	}

}
