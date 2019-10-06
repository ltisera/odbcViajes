/* ------------- Menu ------------- */

$(document).on('click', ".menu__item", function() {
    $(".menu__item").toggleClass("menu__link--select", false);
    $(this).toggleClass("menu__link--select");
    window.location.href = ('http://localhost:5000' + $(this).attr("name"));
    $("#menu").toggleClass("mostrar");
});

$(document).on('click', "#login", function() {
   crearCookie("idUsuarioLogueado", null);
   window.location.href = ('http://localhost:5000')
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


/* ------------- Pasajes ------------- */

function generarTicket(response, texthtml){
    texthtml +=
        "<div class='secTicket'>"                                                    +
            "<div class='container'>"                                                +   
                "<h3 class='main__title'>Pasaje</h3>"                                +
                "<div class='secDatosTicket'>"                                       +
                    "<div class='secTabla1'><p class='pSecTextTick'>Codigo: "        + response[0] + "</p></div>" +
                    "<div class='secTabla2'><p class='pSecTextTick'>Fecha: "         + response[1] + "</p></div>" +
                    "<div class='secTabla1'><p class='pSecTextTick'>Valor: "         + response[2] + "</p></div>" +
                    "<div class='secTabla2'><p class='pSecTextTick'>DNI Pasajero: "  + response[3] + "</p></div>" +
                    "<div class='secTabla1'><p class='pSecTextTick'>Origen: "        + response[4] + "</p></div>" +
                    "<div class='secTabla2'><p class='pSecTextTick'>Destino: "       + response[5] + "</p></div>" +
                    "<div class='secTabla1'><p class='pSecTextTick'>Forma de Pago: " + response[6] + "</p></div>" ;
    if(response[7] == null){
        texthtml += "<button class='cancelar-submit' id='"                           + response[0] + "'>Cancelar</button>";
    }
    else{
        texthtml += "<div class='secTabla2'><p class='pSecTextTick'> El pasaje ha sido cancelado </p></div>";
    }
    texthtml +=
                "</div>"                                                             +
            "</div>"                                                                 +
        "</div>";
    return texthtml
}


$(document).on('click', ".cancelar-submit", function() {
    if(window.confirm("Esta seguro que quiere cancelar su pasaje?")){
        var codPasaje = $(this).attr("id")
        $.ajax({
            url : "cancelarPasaje",
            type : "POST",
            data : {
                codigo : codPasaje,
                fecha: Date()
            },
            success: function(response){
                if(response[0] === "string"){
                    alert(response[0].substring(4));
                }
                else{
                    alert("El pasaje " + codPasaje + " ha sido cancelado, su reintegro es de: " + response[0]);
                    window.location.reload(false);
                }
            },
            error: function(response){
                alert(response.responseJSON.error);
            }
        });
    }
});


/* ------------- Conseguir Data de Opcion ------------- */

function getDataDeOpcion(idSeleccion, dataAConseguir){
    var idOpcion = getIdDeOpcion(idSeleccion)
    var dataConseguida = $("#"+idOpcion).data(dataAConseguir);
    return dataConseguida
}

function getIdDeOpcion(idSeleccion){
    var seleccion = document.getElementById(idSeleccion);
    var idOpcion = seleccion[seleccion.selectedIndex].id; 
    return idOpcion
}

/* ------------- Cookies ------------- */

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

function crearCookie(nombre, valorCookie) {
    var nuevaCookie = nombre + "=" + valorCookie + ";";
    document.cookie = nuevaCookie;
}