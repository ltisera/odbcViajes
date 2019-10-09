package datos;

public class Admin {
	private String nombre;
	private String pass;
	public String getNombre() {
		return nombre;
	}
	
	public Admin(String nombre, String pass) {
		super();
		this.nombre = nombre;
		this.pass = pass;
	}
	public Admin() {
		
		this.nombre = null;
		this.pass = null;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}
	public String getPass() {
		return pass;
	}
	public void setPass(String pass) {
		this.pass = pass;
	}
	
}
