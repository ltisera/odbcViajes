<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>CGI</title>

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
	$.ajax({
		url:"IniciarSesion",
		type:"POST",
		data: {
			"usuario": $("#idInpUser").val(), 
			"pass":$("#idInpPass").val()},
		success: function(response){
			console.log("Lo que se te cante " + response.logueado);
			hideAll();
			traerCiudades();
			$("#divOpc").show();
		},
		error: function(response){alert("Usuario y/o contraseña incorrectos")}
	});
}

function configMillas(){
	$.ajax({
		url:"configMillas",
		type:"POST",
		data: {
			"valor": $("#idInpMillaValor").val(), 
			"Km": $("#idInpMillaKm").val()},
		success: function(response){
			$("#idInpMillaValor").val(""); 
			$("#idInpMillaKm").val("");
			alert("Millas modificadas con exito");
		},
		error: function(response){alert("Error")}
	});
}

function altaCiudad(){
	$.ajax({
		url:"configMillas",
		type:"POST",
		data: {
			"nombre": $("#idInpAltaNombre").val(), 
			"latitud": $("#idInpAltaLat").val(), 
			"longitud": $("#idInpAltaLong").val()},
		success: function(response){
			$("#idInpAltaNombre").val(""); 
			$("#idInpAltaLat").val("");
			$("#idInpAltaLong").val("");
			alert("Ciudad dada de alta con exito");
		},
		error: function(response){alert("Error");}
	});
}

function bajaCiudad(){
	$.ajax({
		url:"configMillas",
		type:"POST",
		data: {
			"id": $("#").val()},
		success: function(response){
			alert("Ciudad dada de baja con exito");
		},
		error: function(response){alert("Error");}
	});
}
	
function traerCiudades(){
     $.ajax({
        url:'traerCiudades', 
        type:'POST',
        success: function(response){
            var strIdCiudad = "0"
            $("#idSelectBaja").append("<option id='idOpcBajaNull'> Seleccionar </option>")
			for(var i = 0; i < response.length; i++){
                strIdCiudad = String(response[i].id);
                $("#idSelectBaja").append("<option class='idOpcBaja' id='" + strIdCiudad + "'>" + response[i].nombre + "</option>")
            }
        },
        error: function(response){
            console.log("ERR Traer Ciudades " + response);
        },

    });
};

function traerCiudadesConBaja(){
    $.ajax({
       url:'traerCiudadesConBaja', 
       type:'POST',
       success: function(response){
           var strIdCiudad = "0"
           $("#idSelectAlta").append("<option id='idOpcAltaNull'> Seleccionar </option>")
			for(var i = 0; i < response.length; i++){
               strIdCiudad = String(response[i].idCiudad)
               $("#idSelectAlta").append("<option class='idOpcAlta' id='" + strIdCiudad + "'>" + response[i].nombre + "</option>")
           }
       },
       error: function(response){
           console.log(response)
       },

   });
};
</script>


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
	<p>Valor por milla: <input id="idInpMillaValor"></input> </p>
	<p>Milla por kilometro: <input id="idInpMillaKm"></input> </p>
	<p><input type="button" value="Modificar" onclick="configMillas()"></input> </p>
	<p><input type="button" value="Volver" onclick="volverOpc()"></input> </p>
</div>

</body>
</html>