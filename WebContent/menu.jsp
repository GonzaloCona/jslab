<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Listar Noticias</title>
<script src="//ajax.googleapis.com/ajax/libs/jquery/2.2.0/jquery.min.js" ></script>
<link href="css/bootstrap.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="js/bootstrap.min.js" ></script>

<%
HttpSession objSesion = request.getSession(false); 
String usuario = (String)objSesion.getAttribute("usuario");
String usuario2= (String)request.getParameter("Name");
if (usuario2==null){
response.sendRedirect("login.jsp");
}
else{
    }
%>

<script>

function estado(objeto,id, indice){
	objeto = document.getElementById(objeto.id);
	var estado;
	if(objeto.checked){
		estado = 1;		 
	}
	else
		estado = 0;
	
	$.ajax({
        url:"http://localhost:8080/fimi_v1/webapi/u/modNoticia;id="+id+";estado="+estado,
        type:'post',
        dataType: 'json',
        success: function(data) {
            if(data.cod_salida == 0){
            	if(estado == 1){//cheked
            		$("#remove"+indice).addClass("success");
            	}else{
            		$("#remove"+indice).removeClass();
            	}            	
            }
            else{
            	$("#remove"+indice).removeClass();
            	$("#remove"+indice).addClass("danger");
            	$('#error1').html("");
            	$('#error1').html("<div class='alert alert-danger' role='alert'><span class='glyphicon glyphicon-exclamation-sign' aria-hidden='true'></span><span class='sr-only'>Error:</span> No se modificó estado</div>");
                
            }                	
        },
        error: function(e) {
        	console.log(e.message);
        }
 	});		
}

function ListarNoticias(){	
		var i;
		var checked;
		var clas;
    	 $.ajax({
            url:"http://localhost:8080/fimi_v1/webapi/u/getNoticias",
            type:'get',
            dataType: 'json',
            success: function(data) {
                if(data[0].cod_salida == 0){
                	
                	$('#tabla').append("<table id='tabla' class='table table-striped table-bordered'> <tr><td width='15%'><b>Fecha</td><td width='15%'><b>Título</td><td width='15%'><b>Contenido</td><td width='15%'><b>Imagen</td><td width='15%'><b>Tipo</td><td width='15%'><b>Estado</td></tr></table>");
                	
                	for (i=0; i< data.length ;i++){
                		if (data[i].estado == 1){
                			checked="'check"+i+"'checked";
                			clas = "class='success'";
                		}
                		else{
                			checked="'check"+i+"'";
                			clas = "";
                		}
                		$('#tabla').append("<tr "+clas+" id ='remove"+i+"'><td>"+data[i].fecha+"</td><td>"+data[i].titulo+"</td><td>"+data[i].contenido+"</td><td>"+data[i].foto+"</td><td>"+data[i].tipo_noticia+"</td><td><div><input type='checkbox' id="+checked+" onclick='estado(this,"+data[i].id+","+i+")'> Habilitar</div></td></tr>");
                		
                	}
                }                	
                else{
                	$('#error1').html("");
                	$('#error1').html("<div class='alert alert-warning' role='alert'>No existen noticias</div>");
                }                	
            },
            error: function(e) {
            	console.log(e.message);
            }
        });
};
</script>

</head>
<body onload="ListarNoticias()">
<h4>Bienvenido <%= (String)request.getParameter("Name") %></h4>
<hr />
	<ul class="nav nav-tabs">
	  <li role="presentation" class="active"><a href="http://localhost:8080/jsflab/menu.jsp?Name=<%= (String)request.getParameter("Name") %>">Noticias</a></li>
	  <li role="presentation"><a href="http://localhost:8080/jsflab/crearNoticia.jsp?Name=<%= (String)request.getParameter("Name") %>">Crear Noticia</a></li>
	  <li role="presentation"><a href="http://localhost:8080/jsflab/usuarios.jsp?Name=<%= (String)request.getParameter("Name") %>">Administradores</a></li>
	</ul>
	<h3>Lista de Noticias</h3> 
	 <table id="tabla" class="table table-striped table-bordered">
	  </table>
	<div id='error1'></div>
	<br /><br /><hr />
</body>
</html>