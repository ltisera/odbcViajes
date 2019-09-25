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
                    cambiarPaginaAPasajes($("#dni").val())
                    /*window.location.href = ('http://localhost:5000/pasajes') */
                }
                else{
                    alert("Usuario o clave incorrectos")
                }
            },
            error: function(response){
                alert(response.responseJSON.error);
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
                    texthtml = texthtml +
                        "<div class='secOrigen'>"                             +
                            "<div class='container'>"                         +   
                                "<h3 class='main__title'>Pasaje</h3>"         +
                                "<div>"                   +
                                    "<h4>Codigo: "        + response[1][i][0] + "</h4>" +
                                    "<h4>Fecha: "         + response[1][i][1] + "</h4>" +
                                    "<h4>Valor: "         + response[1][i][2] + "</h4>" +
                                    "<h4>DNI Pasajero: "  + response[1][i][3] + "</h4>" +
                                    "<h4>Origen: "        + response[1][i][4] + "</h4>" +
                                    "<h4>Destino: "       + response[1][i][5] + "</h4>" +
                                    "<h4>Forma de Pago: " + response[1][i][6] + "</h4>" +
                                    "<button class='cancelar-submit' id='"+response[1][i][0]+"'>Cancelar</button>" +
                                "</div>"                  +
                            "</div>"                      +
                        "</div>";
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


function cambiarPaginaAPasajes(dni) {
    $(".banner").html("<img src='https://incalake.com/galeria/admin/short-slider/BUSES/TITICACA-BOLIVIA/titicaca-bolivia-bus.png' alt='' class='banner__img'>"
        + "<div id='pasajes' class='fondo'>" +
        "</div>")
    $(".login__content").html("<label class='login__link--select login__link' id='login'>Config</label>")
    $("#menu_login").removeClass("mostrar_login");
    traerPasajes(dni)
}