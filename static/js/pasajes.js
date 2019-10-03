
$(document).ready(function(){
    traerCiudadesConVacio("idSelFiltroO", "idSelFiltroD", "filtroOrigen", "filtroDestino");
    traerPasajes(leerCookie("idUsuarioLogueado"));
});

$(document).on('click', "#idFiltroBuscar", function() {
    buscarPasajes();
});

  
function buscarPasajes(){
    var idFiltroO = getDataDeOpcion("idSelFiltroO", "idCiudad");
    var idFiltroD = getDataDeOpcion("idSelFiltroD", "idCiudad");

    if (idFiltroO == null){
        idFiltroO = "Seleccionar";
    }
    if (idFiltroD == null){
        idFiltroD = "Seleccionar";
    }

    $.ajax({
        url : "buscarPasajes",
        type : "POST",
        data : {
            dni : leerCookie("idUsuarioLogueado"),
            origen : idFiltroO,
            destino : idFiltroD,
            desde : $("#idFiltroDesde").val(),
            hasta : $("#idFiltroHasta").val(),
            codigo : $("#idFiltroCodigo").val()
        },
        success: function(response){
            var texthtml = ""
            if (response.length > 0){
                for(var i = 0; i < response.length; i++){
                    texthtml = generarTicket(response[i], texthtml);
                }
            }else{
                texthtml = "<div class='secTicket'>"                        +
                                "<div class='container'>"                   +   
                                    "<h3 class='main__title'>Pasaje</h3>"   +
                                    "<div>"                                 +
                                        "<h4> Pasaje no encontrado </h4>"   +
                                    "</div>"                                +
                                "</div>"                                    +
                            "</div>";
            }
            $("#pasajes").html(texthtml);
        },
        error: function(response){
            alert("Error");
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
            if(response == null){
                $("#pasaje").html("Usted no tiene pasajes");
            }else{
                var texthtml = ""
                if (response.length > 0){
                    for(var i = 0; i < response.length; i++){
                        texthtml = generarTicket(response[i], texthtml);
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

function traerCiudadesConVacio(idSecO, idSecD, idO, idD){
     $.ajax({
        url:'traerCiudades', 
        type:'POST',
        success: function(response){
            var strIdCiudad = "0"
            $("#" + idSecO).append("<option class='opcOrigen' id=\"" + idO + "NULL\"> Seleccionar </option>")
            $("#" + idSecD).append("<option class='opcDestino' id=\"" + idD + "NULL\"> Seleccionar </option>")
            for(var i = 0; i < response.length; i++){
                strIdCiudad = String(response[i].idCiudad)
                $("#" + idSecO).append("<option class='opcOrigen' id=\"" + idO + strIdCiudad + "\">" + response[i].nombre + "</option>")
                $("#" + idSecD).append("<option class='opcDestino' id=\"" + idD + strIdCiudad + "\">" + response[i].nombre + "</option>")
                
                $("#" + idO + strIdCiudad).data("idCiudad", strIdCiudad)
                $("#" + idD + strIdCiudad).data("idCiudad", strIdCiudad)   
            }
        },
        error: function(response){
            console.log(response)
        },

    });
};