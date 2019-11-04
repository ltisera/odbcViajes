package main;
import org.apache.thrift.server.TServer;
import org.apache.thrift.server.TServer.Args;
import org.apache.thrift.server.TSimpleServer;
import org.apache.thrift.transport.TServerSocket;
import org.apache.thrift.transport.TServerTransport;
import org.apache.thrift.transport.TTransportException;

import ejnamespace.serviciosRapido;
import handler.ServiciosRapidoHandler;

public class RPCServer {

	public static ServiciosRapidoHandler handler = new ServiciosRapidoHandler();
	public static serviciosRapido.Processor<ServiciosRapidoHandler> processor = new serviciosRapido.Processor<ServiciosRapidoHandler>(handler);
	
	public static void main(String[] args) {
		Runnable simple = new Runnable() {
	        public void run() {
	          simple(processor);
	        }
	      };      
	     
	      new Thread(simple).start();
	}

	public static void simple(serviciosRapido.Processor<ServiciosRapidoHandler> processor) {
	    TServerTransport serverTransport;
		try {
			serverTransport = new TServerSocket(9090);
			TServer server = new TSimpleServer(new Args(serverTransport).processor(processor));
			
			System.out.println("Iniciando el servidor...");
			server.serve();
		} catch (TTransportException e) {
			e.printStackTrace();
		}
	  }
	
}