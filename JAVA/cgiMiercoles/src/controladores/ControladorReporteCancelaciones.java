package controladores;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.CancelacionDAO;
import datos.Cancelacion;
import datos.Ciudad;

/**
 * Servlet implementation class ControladorReporteCancelaciones
 */
@WebServlet("/ControladorReporteCancelaciones")
public class ControladorReporteCancelaciones extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ControladorReporteCancelaciones() {
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
		System.out.println("LLEGUEEEEE GATO");
		System.out.println("tengo en FA:" + request.getParameter("fechaA"));
		System.out.println("tengo en FB:" + request.getParameter("fechaB"));
		System.out.println("tengo en Orig:" + request.getParameter("origen"));
		System.out.println("tengo en Dest:" + request.getParameter("destino"));
		System.out.println("tengo en Dest null?:" + request.getParameter("destino") == null);
		
		String origen = request.getParameter("origen");
		String destino = request.getParameter("destino");
		String fechaA = request.getParameter("fechaA");
		String fechaB = request.getParameter("fechaB");
		
		CancelacionDAO cdao = new CancelacionDAO();
		List<Cancelacion> cancelaciones = cdao.traerCancelaciones(origen, destino, fechaA, fechaB);
		
		if(cancelaciones.size() > 0) {
			String salidaJson="[";
			for(Cancelacion c : cancelaciones) {
				System.out.println(c);
				salidaJson += "{\"id\":\"" + c.getPasajeCancelado() + "\",\"origen\":\"" + c.getcOrigen() + "\",\"destino\":\"" + c.getcDestino() + "\",\"fecha\":\"" + c.getFecha() + "\",\"reintegro\":\"" + c.getMontoReintegro() + "\"},";
			}
			salidaJson = salidaJson.substring(0, salidaJson.length() - 1) + "]";
			
			System.out.println("JSON-" + salidaJson + "-FinJSON");
			
			response.setContentType("application/json");
			PrintWriter salida = response.getWriter();
			salida.println(salidaJson);
			
			response.setStatus(200);//Usuario y contraseña correctos
		}
		response.setStatus(200);
	}

}
