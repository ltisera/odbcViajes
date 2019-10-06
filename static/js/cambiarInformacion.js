$(document).ready(function(){
    if(leerCookie("idUsuarioLogueado") != "null"){
        $.ajax({
            url : "traerPasajero",
            type : "POST",
            data : {

                dni: leerCookie("idUsuarioLogueado"),
            },
            success: function(response){
                console.log(response)
                $("#nombreUP").val(response[0]);
                $("#apellidoUP").val(response[1]);
                $("#nacionalidadUP").val(response[2]);
                $("#telefonoUP").val(response[3]);
                $("#emailUP").val(response[4]);
                $("#direccionUP").val(response[5]);
            },
            error: function(response){
                console.log("Error en algo");
            }
        });
    }
    else{
        window.location.href = ('http://localhost:5000/')
    }
    
});

$(document).on('click', "#divConfirmarUpdate", function() {
    if( $("#nombreUP").val() != "" &&
        $("#apellidoUP").val() != "" &&
        $("#nacionalidadUP").val() != "" &&
        $("#telefonoUP").val() != "" &&
        $("#emailUP").val() != "" &&
        $("#direccionUP").val() != "" &&
        $("#passwordUP").val() != ""){

        $.ajax({
            url : "updateUsuario",
            type : "POST",
            data : {

                dni: leerCookie("idUsuarioLogueado"),
                nombre: $("#nombreUP").val(),
                apellido: $("#apellidoUP").val(),
                nacionalidad: $("#nacionalidadUP").val(),
                telefono: $("#telefonoUP").val(),
                email: $("#emailUP").val(),
                direccion: $("#direccionUP").val(),
                password : $("#passwordUP").val()
            },
            success: function(response){
                alert("Datos Cambiados");
                window.location.href = ('http://localhost:5000/cambiarInformacion')
            },
            error: function(response){
                console.log("Error en algo");
            }
        });
    }
    else{
        alert("Complete todos los campos");
    }
});