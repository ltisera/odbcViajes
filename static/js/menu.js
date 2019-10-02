/* ------------- Menu ------------- */

$(document).on('click', ".menu__item", function() {
    $(".menu__item").toggleClass("menu__link--select", false);
    $(this).toggleClass("menu__link--select");
    window.location.href = ('http://localhost:5000' + $(this).attr("name"));
    $("#menu").toggleClass("mostrar");
});


/* ------------- Ocultar y Mostrar Nav ------------- */

$(document).on('click', "#btnMenu", function() {
    $("#menu_login").removeClass("mostrar_login");
    $("#menu_nav").toggleClass("mostrar_nav");
});


$(document).on('click', "#login", function() {
   console.log("SALIIIIIIIIIII");
   crearCookie("idUsuarioLogueado", null);
   window.location.href = ('http://localhost:5000')

});



$(document).on('click', "#btnMenu2", function() {
    $("#menu_nav").removeClass("mostrar_nav");
    $("#menu_login").toggleClass("mostrar_login");
});


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

/* ------------- Iniciar Sesion ------------- */

$(document).on('click', "#login-submit", function() {
    if($("#login").hasClass("login__link--select")){
        iniciarSesion();
    }  
    else{
        registrarUsuario();
    }
});

$(document).on('click', ".cancelar-submit", function() {
    if(window.confirm("Esta seguro que quiere cancelar su pasaje?")){
        console.log("cancelar pasaje: " + $(this).attr("id"));
        cancelarPasaje($(this).attr("id"));
    }
    else{
        console.log("miedoso");
    }
});

function registrarUsuario(){
    if($("#dni").val() != "" &&
       $("#nombre").val() != "" &&
       $("#apellido").val() != "" &&
       $("#nacionalidad").val() != "" &&
       $("#telefono").val() != "" &&
       $("#email").val() != "" &&
       $("#direccion").val() != "" &&
       $("#password").val() != ""){
        console.log($("#apellido").val());
        console.log($("#nombre").val());
        console.log($("#email").val());
        console.log($("#password").val());

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
                console.log(response);
                alert("Bien");
            },
            error: function(response){
                console.log("Error en algo");
            }
        });
    }
    else{
        alert("Completa todos los campos");
    }
};

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
                console.log(response);
                if (response[1] == true){
                    crearCookie("idUsuarioLogueado", $("#dni").val());
                    window.location.href = ('http://localhost:5000/pasajes')
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

function cancelarPasaje(codigo){
    $.ajax({
        url : "cancelarPasaje",
        type : "POST",
        data : {
            codigo : codigo,
            fecha: Date()
        },
        success: function(response){
            console.log(response);
        },
        error: function(response){
            alert(response.responseJSON.error);
        }
    });
};

function traerPasajes(dni){
    $.ajax({
        url : "traerPasajes",
        type : "POST",
        data : {
            dni : dni,
        },
        success: function(response){
            if(response[1] == null){
                $("#pasaje").html("Usted no tiene pasajes");
            }else{
                console.log(response[1]);
                var texthtml = ""
                if (response[1].length > 0){
                    for(var i = 0; i < response[1].length; i++){
                        texthtml = generarTicket(response[1][i], texthtml);
                        
                    }
                }else{
                    texthtml = "<div class='secOrigen'>"                        +
                                    "<div class='container'>"                   +   
                                        "<h3 class='main__title'>Pasaje</h3>"   +
                                        "<div>"                                 +
                                            "<h4> Usted no tiene pasajes </h4>" +
                                        "</div>"                                +
                                    "</div>"                                    +
                                "</div>";
                }
                $("#pasajes").html(texthtml);
            }
        },
        error: function(response){
            alert(response.responseJSON.error);
        }
    });
}


function generarTicket(response, texthtml){
    texthtml = texthtml +
        "<div class='secTicket'>"                             +
            "<div class='container'>"                         +   
                "<h3 class='main__title'>Pasaje</h3>"         +
                "<div class='secDatosTicket'>"                   +
                    "<div class='secTabla1'><p class='pSecTextTick'>Codigo: "        + response[0] + "</p></div>" +
                    "<div class='secTabla2'><p class='pSecTextTick'>Fecha: "         + response[1] + "</p></div>" +
                    "<div class='secTabla1'><p class='pSecTextTick'>Valor: "         + response[2] + "</p></div>" +
                    "<div class='secTabla2'><p class='pSecTextTick'>DNI Pasajero: "  + response[3] + "</p></div>" +
                    "<div class='secTabla1'><p class='pSecTextTick'>Origen: "        + response[4] + "</p></div>" +
                    "<div class='secTabla2'><p class='pSecTextTick'>Destino: "       + response[5] + "</p></div>" +
                    "<div class='secTabla1'><p class='pSecTextTick'>Forma de Pago: " + response[6] + "</p></div>" +
                    "<button class='cancelar-submit' id='"+response[0]+"'>Cancelar</button>" +
                "</div>"                  +
            "</div>"                      +
        "</div>";
    return texthtml
}

function crearCookie(nombre, valorCookie) {
    var nuevaCookie = nombre + "=" + valorCookie + ";";
    document.cookie = nuevaCookie;
}

function leerCookie(nombre) {
    var Nombre = nombre + "=";
    var cRy = document.cookie.split(';');// el array de las cookies
    for(var i=0;i < cRy.length;i++) {
        var c = cRy[i];// la cookie
        //recorta cualquier espacio en blanco al inicio:
        while (c.charAt(0)==' ') c = c.substring(1,c.length);
        // devuelve el valor de la cookie
        if (c.indexOf(Nombre) == 0) return c.substring(Nombre.length,c.length);
    }
    // si ninguna cookie no fue encontrada
    return null;
}