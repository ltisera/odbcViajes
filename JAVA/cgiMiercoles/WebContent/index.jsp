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
	hideAll();
	$("#divLogin").show();
	
	$(".opc").click(function() {
		hideAll();
		$("#div" + this.id).show();
	});
});

function volverOpc(){
	hideAll();
	$("#divOpc").show();
}

function hideAll(){
	$("#divLogin").hide();
	$("#divOpc").hide();
	$("#divEmitirReportes").hide();
	$("#divAltaCiudad").hide();
	$("#divBajaCiudad").hide();
	$("#divConfigMillas").hide();
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
				$("#divOpc").show();
			},
			error: function(response){alert("Usuario y/o contraseņa incorrectos")}
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
		},
		error: function(response){console.log("Genero para mal")},
	});
}

</script>
<style>
.opc:hover {
  background-color: orange;
}
</style>

</head>
<body>
<div id="divLogin">
	<p>Ingrese Usuario: <input id="idInpUser"></input> </p>
	<p>Ingrese Password: <input id="idInpPass" type="password"></input> </p>
	<p><input type="button" value="Click me" onclick="login()"></input> </p>
</div>
<div id="divOpc">
	<p id="EmitirReportes" class="opc">Emitir reportes</p>
	<p id="AltaCiudad" class="opc">Dar de alta ciudades</p>
	<p id="BajaCiudad" class="opc">Dar de baja ciudades</p>
	<p id="ConfigMillas" class="opc">Modificar millas</p>
</div>
<div id="divEmitirReportes">
	<p>Emitir reportes</p>
	<div class="clsCajita">
		<p>Seleccione las fechas entre las cuales se generara el reporte de cancelaciones</p>
		<input type="date" id="idFechaReporteInicio" name="trip-start" value="2019-09-24">
		<input type="date" id="idFechaReporteFin" name="trip-start" value="2019-09-24">
		<p>Seleccione ciudades de destino y origen</p>
		<select id="idSelectReporteOrigen"></select>
		<select id="idSelectReporteDestino"></select>
		<p><input type="button" value="Generar Reporte" onclick="reporteCancelaciones()"></input> </p>
	</div>
	
	
	<p><input type="button" value="Volver" onclick="volverOpc()"></input> </p>
</div>
<div id="divAltaCiudad">
	<p>Alta ciudad</p>
	<p>Nombre de ciudad: <input id="idInpAltaNombre"></input> </p>
	<p>Longitud: <input id="idInpAltaLong"></input> </p>
	<p>Latitud: <input id="idInpAltaLat"></input> </p>
	<p><input type="button" value="Dar de Alta" onclick="altaCiudad()"></input> </p>
	
	<select id="idSelectAlta"></select>
	<p><input type="button" value="Dar de Alta" onclick="altaCiudadConBaja()"></input> </p>
	<p><input type="button" value="Volver" onclick="volverOpc()"></input> </p>
</div>
<div id="divBajaCiudad">
	<p>Baja ciudad</p>
	<select id="idSelectBaja"></select>
	<p><input type="button" value="Dar de Baja" onclick="bajaCiudad()"></input> </p>
	<p><input type="button" value="Volver" onclick="volverOpc()"></input> </p>
</div>
<div id="divConfigMillas">
	<p>Configurar Millas</p>
	<p>Valor por milla: <input type="number" id="idInpMillaValor"></input> </p>
	<p>Milla por kilometro: <input type="number" id="idInpMillaKm"></input> </p>
	<p><input type="button" value="Modificar" onclick="configMillas()"></input> </p>
	<p><input type="button" value="Volver" onclick="volverOpc()"></input> </p>
</div>

</body>
</html>