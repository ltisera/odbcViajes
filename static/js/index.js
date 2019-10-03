/* ------------- Document Ready ------------- */

var map = null
var map2 = null
$(document).ready(function(){
    
    console.log(leerCookie("idUsuarioLogueado"));
    calcularFecha("idFechaViaje");

    if(leerCookie("idUsuarioLogueado") != "null"){
        $(".login__content").html("<label class='login__link--select login__link' id='login'>Salir</label>");
        $("#ingreseDatos").removeClass("secDestino");
        $("#ingreseDatos").toggleClass("ocultar");
        document.getElementById("linkConsultar").setAttribute("name","/pasajes");
    }
    else{
        $("#metodoPago").removeClass("secDestino");
        $("#metodoPago").toggleClass("ocultar");   
    }

    $("#divSecNueva").click(seleccionarViaje);
    $("#divConfirmarViaje").click(confirmarViaje);

    /*Mapas*/
    traerCiudadesConLatLon("lstOrigen", "lstDestino", "origen", "destino", true);
    
    map = L.map('mapOrigen').setView([-34.61, -58.37], 3);
    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {}).addTo(map);

    map2 = L.map('mapDestino').setView([-34.61, -58.37], 3);
    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {}).addTo(map2);
    
});


/* ------------- Iniciar Sesion / Registrar ------------- */

$(document).on('click', ".login__link", function() {
    var toggle = false;
    $("#login-submit").html("Registrar");
    if($(this).attr("id") == "login"){
        toggle = true;
        $("#login-submit").html("Entrar");
    }
    
    $("#divRegistro").toggleClass("ocultar", toggle);
    $("#login").toggleClass("login__link--select", toggle);
    $("#registro").toggleClass("login__link--select", !toggle);
});

$(document).on('click', "#login-submit", function() {
    if($("#login").hasClass("login__link--select")){
        iniciarSesion();
    }  
    else{
        registrarUsuario();
    }
});

function iniciarSesion(){
    if($("#dni").val() == ""){
        alert("Debe ingresar usuario");
    }
    else if($("#password").val() == ""){
        alert("Debe ingresar password");
    }
    else{
        $.ajax({
            url : "login",
            type : "POST",
            data : {
                dni : $("#dni").val(),
                clave : $("#password").val()
            },
            success: function(response){
                if (response == true){
                    crearCookie("idUsuarioLogueado", $("#dni").val());
                    $(".login__content").html("<label class='login__link--select login__link' id='login'>Salir</label>");
                    $("#ingreseDatos").removeClass("secDestino");
                    $("#ingreseDatos").toggleClass("ocultar");
                    document.getElementById("linkConsultar").setAttribute("name","/pasajes");
                    $("#menu_nav").removeClass("mostrar_nav");
                    $("#menu_login").toggleClass("mostrar_login");
                    $("#metodoPago").removeClass("ocultar");
                    $("#metodoPago").toggleClass("secDestino");
                }
                else{
                    alert("Usuario o clave incorrectos")
                }
            },
            error: function(response){
                alert("response.responseJSON.error");
            }
        });
    }
};

function registrarUsuario(){
    if($("#dni").val() != "" &&
       $("#nombre").val() != "" &&
       $("#apellido").val() != "" &&
       $("#nacionalidad").val() != "" &&
       $("#telefono").val() != "" &&
       $("#email").val() != "" &&
       $("#direccion").val() != "" &&
       $("#password").val() != ""){

        $.ajax({
            url : "registrar",
            type : "POST",
            data : {
                dni : $("#dni").val(),
                nombre : $("#nombre").val(),
                apellido : $("#apellido").val(),
                nacionalidad : $("#nacionalidad").val(),
                telefono : $("#telefono").val(),
                email : $("#email").val(),
                direccion : $("#direccion").val(),
                password : $("#password").val()
            },
            success: function(response){
                alert("El usuario ha sido registrado exitosamente");
            },
            error: function(response){
                alert("Error al registrar");
            }
        });
    }
    else{
        alert("Complete todos los campos");
    }
};


/* ------------- Traer Ciudades ------------- */

function traerCiudadesConLatLon(idSecO, idSecD, idO, idD){
     $.ajax({
        url:'traerCiudades', 
        type:'POST',
        success: function(response){
            var strIdCiudad = "0"
            for(var i = 0; i < response.length; i++){
                strIdCiudad = String(response[i].idCiudad)
                $("#" + idSecO).append("<option class='opcOrigen' id=\"" + idO + strIdCiudad + "\">" + response[i].nombre + "</option>")
                $("#" + idSecD).append("<option class='opcDestino' id=\"" + idD + strIdCiudad + "\">" + response[i].nombre + "</option>")
                
                $("#" + idO + strIdCiudad).data("latitud", response[i].latitud)
                $("#" + idO + strIdCiudad).data("longitud", response[i].longitud)
                $("#" + idO + strIdCiudad).data("idCiudad", strIdCiudad)

                $("#" + idD + strIdCiudad).data("latitud", response[i].latitud)
                $("#" + idD + strIdCiudad).data("longitud", response[i].longitud)
                $("#" + idD + strIdCiudad).data("idCiudad", strIdCiudad)

                L.marker([response[i].latitud, response[i].longitud]).addTo(map)
                    .bindPopup(response[i].nombre)
                L.marker([response[i].latitud, response[i].longitud]).addTo(map2)
                    .bindPopup(response[i].nombre)
            }
        },
        error: function(response){
            console.log(response)
        },

    });
};


/* ------------- Calcular Fecha ------------- */

function calcularFecha(idCalendario){
    var today = new Date();
    var day = today.getDate();
    var mes = today.getMonth()+1;
    if (day < 9){
        day = "0" + day;
    }
    if (mes < 9){
        mes = "0" + mes;
    }
    var minFecha = today.getFullYear()+'-'+mes+'-'+day;
    var maxFecha = (today.getFullYear()+2)+'-'+mes+'-'+day;

    $("#" + idCalendario).attr("value", minFecha)
    $("#" + idCalendario).attr("min", minFecha)
    $("#" + idCalendario).attr("max", maxFecha)
}


/* ------------- Click en Origen / Destino ------------- */
        
function clickListOrigen(){
    var idSeleccionado = getIdDeOpcion("lstOrigen"); 
    var lat = $("#"+idSeleccionado).data("latitud");
    var long = $("#"+idSeleccionado).data("longitud");

    map.setView([lat, long], 6);   
}

function clickListDestino(){
    var idSeleccionado = getIdDeOpcion("lstDestino"); 
    var lat = $("#"+idSeleccionado).data("latitud");
    var long = $("#"+idSeleccionado).data("longitud");

    map2.setView([lat, long], 6);
}


/* ------------- Crear Viaje ------------- */

function seleccionarViaje(){
    
    var idOrigenT = getIdDeOpcion("lstOrigen");
    var idOrigen = $("#"+idOrigenT).data("idCiudad");

    var idDestinoT = getIdDeOpcion("lstDestino");
    var idDestino = $("#"+idDestinoT).data("idCiudad");

    $.ajax({
        url: 'seleccionarViaje',
        type: 'POST',
        data:{
            idCiudadOrigen: idOrigen,
            idCiudadDestino: idDestino
        },
        success: function(response){
            $("#selecDestinos").toggleClass("fondo");
            $("#selecDestinos").toggleClass("ocultar");
            $("#confirmViaje").toggleClass("ocultar");
            $("#confirmViaje").toggleClass("fondo");

            texthtml =
            "<h3 class='main__title'>Pasaje</h3>"         +
            "<div class='secDatosTicket'>"                   +
                "<div class='secTabla1'><p class='pSecTextTick'>Valor: "   + response.valor + "</p></div>" +
                "<div class='secTabla2'><p class='pSecTextTick'>Origen: "  + $("#"+idOrigenT).html() + "</p></div>" +
                "<div class='secTabla1'><p class='pSecTextTick'>Destino: " + $("#"+idDestinoT).html()  + "</p></div>" +
                "<div class='secTabla2'><p class='pSecTextTick'>Millas Obtenidas: " + response.millas + "</p></div>" +
            "</div>";
            $("#confirmDatosTicket").html(texthtml);
            console.log(response)
        },
        error: function(response){
            console.log("ERR")
        },
    });
}


function confirmarViaje(){
    var idOrigen = getDataDeOpcion("lstOrigen", "idCiudad");
    var idDestino = getDataDeOpcion("lstDestino", "idCiudad");

    if(leerCookie("idUsuarioLogueado") != "null"){
        viajeUsuario(idOrigen, idDestino);
    }
    else{
        viajeCasual(idOrigen, idDestino);
    }
    
}


function viajeUsuario(idOrigen, idDestino){
    $.ajax({
        url : "confirmarViajeUsuario",
        type : "POST",
        data : {

            idCiudadOrigen: idOrigen,
            idCiudadDestino: idDestino,
            fecha: $("#idFechaViaje").val(),
            formaPago: $("#metodoPagoCV").val(),
            dni: leerCookie("idUsuarioLogueado")
        },
        success: function(response){
            alert("Codigo de pasaje: ");
            window.location.href = ('http://localhost:5000')
        },
        error: function(response){
            console.log("Error en algo");
        }
    });
}

function viajeCasual(idOrigen, idDestino){
    if($("#dniCV").val() != "" &&
        $("#nombreCV").val() != "" &&
        $("#apellidoCV").val() != "" &&
        $("#nacionalidadCV").val() != "" &&
        $("#telefonoCV").val() != "" &&
        $("#emailCV").val() != "" &&
        $("#direccionCV").val() != ""){

        $.ajax({
            url : "confirmarViajeCasual",
            type : "POST",
            data : {

                idCiudadOrigen: idOrigen,
                idCiudadDestino: idDestino,
                fecha: $("#idFechaViaje").val(),
                dni: $("#dniCV").val(),
                nombre: $("#nombreCV").val(),
                apellido: $("#apellidoCV").val(),
                nacionalidad: $("#nacionalidadCV").val(),
                telefono: $("#telefonoCV").val(),
                email: $("#emailCV").val(),
                direccion: $("#direccionCV").val(),
            },
            success: function(response){
                alert("Codigo de pasaje: ");
                window.location.href = ('http://localhost:5000')
            },
            error: function(response){
                console.log("Error en algo");
            }
        });
    }
    else{
        alert("Complete todos los campos");
    }
}