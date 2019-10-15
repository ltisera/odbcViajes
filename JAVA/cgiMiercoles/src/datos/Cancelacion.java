package datos;

import java.sql.Date;
import java.util.GregorianCalendar;

public class Cancelacion {
	private String pasajeCancelado;
	private String cOrigen;
	private String cDestino;
	private Date fecha;
	private float montoReintegro;
	public String getPasajeCancelado() {
		return pasajeCancelado;
	}
	public void setPasajeCancelado(String pasajeCancelado) {
		this.pasajeCancelado = pasajeCancelado;
	}
	public String getcOrigen() {
		return cOrigen;
	}
	public void setcOrigen(String cOrigen) {
		this.cOrigen = cOrigen;
	}
	public String getcDestino() {
		return cDestino;
	}
	public void setcDestino(String cDestino) {
		this.cDestino = cDestino;
	}
	public Date getFecha() {
		return fecha;
	}
	public void setFecha(Date fecha) {
		this.fecha = fecha;
	}
	public float getMontoReintegro() {
		return montoReintegro;
	}
	public void setMontoReintegro(float montoReintegro) {
		this.montoReintegro = montoReintegro;
	}
	public Cancelacion(String pasajeCancelado, String cOrigen, String cDestino, Date fecha, float montoReintegro) {
		super();
		this.pasajeCancelado = pasajeCancelado;
		this.cOrigen = cOrigen;
		this.cDestino = cDestino;
		this.fecha = fecha;
		this.montoReintegro = montoReintegro;
	}
	@Override
	public String toString() {
		return "Cancelacion [pasajeCancelado=" + pasajeCancelado + ", cOrigen=" + cOrigen + ", cDestino=" + cDestino
				+ ", fecha=" + fecha + ", montoReintegro=" + montoReintegro + "]";
	}

}
