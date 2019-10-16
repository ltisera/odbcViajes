<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>CGI</title>
<link rel="stylesheet" type="text/css" href="css/estilos.css">
<script src="js/jquery-3.4.1.min.js" type="text/javascript"></script>
<script>

$(document).ready(function(){
	$(".opc").click(function() {
		if(this.id == "Logout"){
			location.reload();
		}else{
			hideAll();
			$("#div" + this.id).removeClass("ocultar");	
		}
	});
});

function volverOpc(){
	hideAll();
	$("#divOpc").removeClass("ocultar");
}

function hideAll(){
	$("#divLogin").addClass("ocultar");
	$("#divOpc").addClass("ocultar");
	$("#divEmitirReportes").addClass("ocultar");
	$("#divAltaCiudad").addClass("ocultar");
	$("#divBajaCiudad").addClass("ocultar");
	$("#divConfigMillas").addClass("ocultar");
}


function login(){
	if($("#idInpUser").val() != "" && $("#idInpPass").val() != ""){
		$.ajax({
			url:"IniciarSesion",
			type:"POST",
			data: {
				"usuario": $("#idInpUser").val(), 
				"pass":$("#idInpPass").val()},
			success: function(response){
				hideAll();
				traerCiudades();
				$("#divOpc").removeClass("ocultar");
			},
			error: function(response){alert("Usuario y/o contraseña incorrectos")}
		});
	} else{
		alert("Ingrese todos los datos");
	}
}

function configMillas(){
	if($("#idInpMillaValor").val() != "" && $("#idInpMillaKm").val() != ""){
		$.ajax({
			url:"configMillas",
			type:"POST",
			data: {
				"valor": $("#idInpMillaValor").val(), 
				"km": $("#idInpMillaKm").val()},
			success: function(response){
				$("#idInpMillaValor").val(""); 
				$("#idInpMillaKm").val("");
				alert("Millas modificadas con exito");
			},
			error: function(response){alert("Error")}
		});
	}else{
		alert("Ingrese todos los datos");
	}
}

function altaCiudad(){
	if($("#idInpAltaNombre").val() != "" && $("#idInpAltaLat").val() != "" && $("#idInpAltaLong").val() != ""){
		$.ajax({
			url:"altaCiudad",
			type:"POST",
			data: {
				"nombre": $("#idInpAltaNombre").val(), 
				"latitud": $("#idInpAltaLat").val(), 
				"longitud": $("#idInpAltaLong").val()},
			success: function(response){
				$("#idInpAltaNombre").val(""); 
				$("#idInpAltaLat").val("");
				$("#idInpAltaLong").val("");
				traerCiudades();
				alert("Ciudad dada de alta con exito");
			},
			error: function(response){alert("Error");}
		});	
	}else{
		alert("Ingrese todos los datos");
	}
	
}

function altaCiudadConBaja(){
	var seleccion = document.getElementById("idSelectAlta");
    var idOpcion = seleccion[seleccion.selectedIndex].id; 
    if(idOpcion != "Null"){
		$.ajax({
			url:"altaCiudadConBaja",
			type:"POST",
			data: {
				"id": idOpcion
			},
			success: function(response){
				traerCiudades();
				alert("Ciudad dada de alta con exito");
			},
			error: function(response){alert("Error");}
		});
    }
}

function bajaCiudad(){
	var seleccion = document.getElementById("idSelectBaja");
    var idOpcion = seleccion[seleccion.selectedIndex].id; 
	if(idOpcion != "Null"){
		$.ajax({
			url:"bajaCiudad",
			type:"POST",
			data: {
				"id": idOpcion},
			success: function(response){
				traerCiudades();
				alert("Ciudad dada de baja con exito");
			},
			error: function(response){alert("Error");}
		});
	}else{
		alert("Seleccione una ciudad");
	}
   
}
	
function traerCiudades(){
     $.ajax({
        url:'traerCiudades', 
        type:'POST',
        success: function(response){
        	$("#idSelectBaja").html("");
            $("#idSelectBaja").append("<option id='Null'> Seleccionar </option>");
            $("#idSelectAlta").html("");
            $("#idSelectAlta").append("<option id='Null'> Seleccionar </option>");
            $("#idSelectReporteOrigen").html("");
            $("#idSelectReporteOrigen").append("<option id='null'> Origen </option>");
            $("#idSelectReporteDestino").html("");
            $("#idSelectReporteDestino").append("<option id='null'> Destino </option>");
			for(var i = 0; i < response.length; i++){
				if(response[i].baja == "false"){
					$("#idSelectBaja").append("<option class='idOpcBaja' id='" + response[i].id + "'>" + response[i].nombre + "</option>");
				}else{
					$("#idSelectAlta").append("<option class='idOpcAlta' id='" + response[i].id + "'>" + response[i].nombre + "</option>");
				}
				$("#idSelectReporteOrigen").append("<option class='idOpcReporteOrigen' id='" + response[i].id + "'>" + response[i].nombre + "</option>");
				$("#idSelectReporteDestino").append("<option class='idOpcReporteDestino' id='" + response[i].id + "'>" + response[i].nombre + "</option>");
            }
        },
        error: function(response){
            console.log("ERR Traer Ciudades " + response);
        },
    });
};

function reporteCancelaciones(){
	console.log("Reportar");
	var seleccionOrigen = document.getElementById("idSelectReporteOrigen");
    var idOpcionOrigen = seleccionOrigen[seleccionOrigen.selectedIndex].id; 
    
    var seleccionDestino = document.getElementById("idSelectReporteDestino");
    var idOpcionDestino = seleccionDestino[seleccionDestino.selectedIndex].id;
	$.ajax({
		url: "reporteCancelaciones",
		type: "POST",
		data:{
			"fechaA":$("#idFechaReporteInicio").val(),
			"fechaB":$("#idFechaReporteFin").val(),
			"origen" : idOpcionOrigen,
			"destino" : idOpcionDestino,
			},
		success: function(response){
			console.log("Genero para bien");
			console.log(response);
			var total = 0;
			var text = "<tr> <th>Pasaje</th> <th>Origen</th> <th>Destino</th> <th>Fecha</th> <th>Reintegro</th> </tr>";
			for(var i = 0; i < response.length; i++){
				text += "<tr> <td>" + response[i].id + "</td>";
				text += "<td>" + response[i].origen + "</td>";
				text += "<td>" + response[i].destino + "</td>";
				text += "<td>" + response[i].fecha + "</td>";
				text += "<td>" + response[i].reintegro + "</td> </tr>";
				total += parseFloat(response[i].reintegro);
			}
			text += "<tr> <td></td> <td></td> <td></td> <td>Total</td> <td>" + total + "</td> </tr>";
			$("#idContenidoReporte").html(text);
		},
		error: function(response){console.log("Genero para mal")},
	});
}

</script>

</head>
<body>
<div id="divLogin">
	<div class="clsBarraOpc">
		<p>Login</p>
	</div>
	<div class="clsCajita">
		<p>Ingrese Usuario: <input id="idInpUser"></input> </p>
		<p>Ingrese Password: <input id="idInpPass" type="password"></input> </p>
		<p><input type="button" value="Conectar" onclick="login()"></input> </p>
	</div>
</div>
<div class="ocultar" id="divOpc">
	<div class="clsBarraOpc"><p>Seleccione una opcion</p></div>
	<div id="EmitirReportes" class="opc"><p>Emitir reportes</p></div>
	<div id="AltaCiudad" class="opc"><p>Dar de alta ciudades</p></div>
	<div id="BajaCiudad" class="opc"><p>Dar de baja ciudades</p></div>
	<div id="ConfigMillas" class="opc"><p>Modificar millas</p></div>
	<div id="Logout" class="opc"><p>Cerrar Sesion</p></div>
</div>
<div class="ocultar" id="divEmitirReportes">
	<div class="clsBarraOpc">
		<p>Emitir reportes</p>
	</div>
	<div class="clsCajita">
		<p>Seleccione las fechas entre las cuales se generara el reporte de cancelaciones</p>
		<input type="date" id="idFechaReporteInicio" name="trip-start" value="2019-09-24">
		<input type="date" id="idFechaReporteFin" name="trip-start" value="2019-09-24">
		<p>Seleccione ciudades de destino y origen</p>
		<select id="idSelectReporteOrigen"></select>
		<select id="idSelectReporteDestino"></select>
		<p><input type="button" value="Generar Reporte" onclick="reporteCancelaciones()"></input> </p>
		<table id="idContenidoReporte"></table>
	</div>
	<p><input class="clsBtnVolver" type="button" value="Volver" onclick="volverOpc()"></input> </p>
</div>
<div class="ocultar" id="divAltaCiudad">
	<div class="clsBarraOpc">
		<p>Alta Ciudad</p>
	</div>
	<div class="clsCajita">
		<p>Nombre: <input id="idInpAltaNombre"></input> </p>
		<p>Longitud: <input id="idInpAltaLong"></input> </p>
		<p>Latitud: <input id="idInpAltaLat"></input> </p>
		<p><input type="button" value="Dar de Alta" onclick="altaCiudad()"></input> </p>
	</div>
	<div class="clsCajita">
		<select id="idSelectAlta"></select>
		<p><input type="button" value="Dar de Alta" onclick="altaCiudadConBaja()"></input> </p>
	</div>
	<p><input class="clsBtnVolver" type="button" value="Volver" onclick="volverOpc()"></input> </p>
</div>
<div class="ocultar" id="divBajaCiudad">
	<div class="clsBarraOpc">
		<p>Baja Ciudad</p>
	</div>
	<div class="clsCajita">
		<select id="idSelectBaja"></select>
		<p><input type="button" value="Dar de Baja" onclick="bajaCiudad()"></input> </p>
	</div>
	<p><input class="clsBtnVolver" type="button" value="Volver" onclick="volverOpc()"></input> </p>
</div>
<div class="ocultar" id="divConfigMillas">
	<div class="clsBarraOpc">
		<p>Configurar Millas</p>
	</div>
	<div class="clsCajita">
		<p>Valor por milla: <input type="number" id="idInpMillaValor"></input> </p>
		<p>Milla por kilometro: <input type="number" id="idInpMillaKm"></input> </p>
		<p><input type="button" value="Modificar" onclick="configMillas()"></input> </p>
	</div>
	<p><input class="clsBtnVolver" type="button" value="Volver" onclick="volverOpc()"></input> </p>
</div>

</body>
</html>