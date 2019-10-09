package datos;

public class Ciudad {
	private int idCiudad;
	private String nombre;
	private String longitud;
	private String latitud;
	
	public Ciudad() {
	}
	
	public Ciudad(int idCiudad, String nombre, String longitud, String latitud) {
		super();
		this.idCiudad = idCiudad;
		this.nombre = nombre;
		this.longitud = longitud;
		this.latitud = latitud;
	}
	public int getIdCiudad() {
		return idCiudad;
	}
	public void setIdCiudad(int idCiudad) {
		this.idCiudad = idCiudad;
	}
	public String getNombre() {
		return nombre;
	}
	public void setNombre(String nombre) {
		this.nombre = nombre;
	}
	public String getLongitud() {
		return longitud;
	}
	public void setLongitud(String longitud) {
		this.longitud = longitud;
	}
	public String getLatitud() {
		return latitud;
	}
	public void setLatitud(String latitud) {
		this.latitud = latitud;
	}
	
	
	
	
}
