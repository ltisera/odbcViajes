package controladores;

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
		float vmillas = Float.parseFloat(valor);
		float vkm = Float.parseFloat(km);
		
		AdminDAO adao = new AdminDAO(); 
		boolean u = adao.configMillas(vmillas, vkm);
		//response.setContentType("application/json");
		if(u==true) {
			response.setStatus(200);//Millas modificadas
		}
		else {
			response.setStatus(500);//Error
		}
	}

}
