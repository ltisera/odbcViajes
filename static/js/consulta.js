$(document).on('click', "#consulta-submit", function() {
    if($("#codigo").val() == ""){
        alert("Debe ingresar el codigo");
    }
    else{
        $.ajax({
            url : "traerPasaje",
            type : "POST",
            data : {
                codigo : $("#codigo").val(),
            },
            success: function(response){
                if(response == null){
                    $("#idPasajeContenido").html("Pasaje no encontrado");
                }else{
                    $("#idPasajeContenido").html(generarTicket(response, ""));
                }
            },
            error: function(response){
                alert(response.responseJSON.error);
            }
        });
    }
});