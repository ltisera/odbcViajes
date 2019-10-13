package controladores;


import java.io.PrintWriter;
import java.util.List;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import dao.CiudadDAO;
import datos.Ciudad;

@WebServlet("/ControladorTraerCiudadesConBaja")
public class ControladorTraerCiudadesConBaja extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public ControladorTraerCiudadesConBaja() {
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
		System.out.println("Soy Controlador Traer Ciudades con Baja");

		response.setContentType("application/json");
		String salidaJson="[";
		CiudadDAO cdao = new CiudadDAO(); 
		List<Ciudad> ciudades = cdao.traerCiudadesConBaja();
		
		
		if(ciudades.size() > 0) {
			for(Ciudad c : ciudades) {
				salidaJson += "{\"id\":\"" + c.getIdCiudad() + "\",\"nombre\":\"" + c.getNombre() + "\"},";
			}
			salidaJson = salidaJson.substring(0, salidaJson.length() - 1) + "]";
			
			System.out.println(salidaJson);
			PrintWriter salida = response.getWriter();
			salida.println(salidaJson);
			
			response.setStatus(200);//Usuario y contraseña correctos
		}
		else {

			System.out.println("Error");
			response.setStatus(500);//Usuario y/o contraseña incorrectos
		}
	}

}
