<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>

<script src="js/jquery-3.4.1.min.js" type="text/javascript"></script>
<script>
function llama(){
	
	console.log("ESTOY LLAMANDO PERO NO SE LO QUE ES UN AJAX")
	$.ajax({
		url:"IniciarSesion",
		type:"POST",
		data: {"usuario":"lucas", "pass":"1234"},
		success: function(response){console.log("Lo que se te cante" + response)},
		error: function(response){console.log("ERROR" + response)}
	});
}
</script>


</head>
<body>
<div>
	Ingrese Usuario: <input>
	<br>
	Ingrese Password: <input>
	<br>
	<input type="button" value="Click me" onclick="llama()">
</div>

</body>
</html>