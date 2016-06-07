<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Crear Noticia</title>
<script src="//ajax.googleapis.com/ajax/libs/jquery/2.2.0/jquery.min.js" ></script>
<link href="css/bootstrap.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="js/bootstrap.min.js" ></script>
<%
HttpSession objSesion = request.getSession(false); 
String usuario = (String)objSesion.getAttribute("usuario");
String usuario2= (String)request.getParameter("Name");

//if (usuario2==null){
//response.sendRedirect("login.jsp");
//}
//else{
	//out.println("Usuario en sesion con datos:usuario " + usuario);
	//out.println("Usuario en sesion :" + usuario2); 
//    }
%>

<script>

function ingresarNoticia(){
	var user = '<%= (String)request.getParameter("Name") %>';
	
	
	if(document.getElementById('titulo').value && document.getElementById('contenido').value && document.getElementById('imagen').value){
		var title = document.getElementById('titulo').value;
		var content = document.getElementById('contenido').value;
		var a_modificar = document.getElementById('imagen').value;
		var buscar="/"
		var url = a_modificar.replace(new RegExp(buscar,"g")," ");
		var tipo =  1;
	}
	else if(document.getElementById('imagen2').value){
			var title = "";
			var content = "";
			var a_modificar = document.getElementById('imagen2').value;
			var buscar="/"
			var url = a_modificar.replace(new RegExp(buscar,"g")," ");
			var tipo =  2;
		}
		else if(document.getElementById('contenido3').value && document.getElementById('imagen3').value){
			var title = "";
			var content = document.getElementById('contenido3').value;
			var a_modificar = document.getElementById('imagen3').value;
			var buscar="/"
			var url = a_modificar.replace(new RegExp(buscar,"g")," ");
			var tipo =  3;
		}
		else{
			$('#error1').html("");
        	$('#error1').html("<div class='alert alert-warning' role='alert'><span class='glyphicon glyphicon-exclamation-sign' aria-hidden='true'></span><span class='sr-only'>Error:</span> Debe completar todos los campos</div>");
            
		}
	
	var fecha = new Date();
	
	fecha = fecha.yyyymmdd();
    $.ajax({               
        url:"http://localhost:8080/fimi_v1/webapi/u/setNoticia;seccion=seccion1;contenido="+content+";titulo="+title+";foto="+url+";tipo="+tipo+";estado=1;fecha="+fecha,
        type:'post',
        dataType: 'json',
        success: function(data) {
            if(data.cod_salida == 0){
            	$('#error1').html("");
            	$('#error1').html("<div class='alert alert-success' role='alert'>Noticia agregada exitosamente</div>");
            }
            else{
            	$('#error').html("");
            	$('#error1').html("<div class='alert alert-danger' role='alert'><span class='glyphicon glyphicon-exclamation-sign' aria-hidden='true'></span><span class='sr-only'>Error:</span> No se agregó la noticia</div>");
            }                	
        },
        error: function(e) {
        	console.log(e.message);
        }
    });
    
    return false;	
}

function mostrar(id) {
	
	if($('#error1').html() != ""){
		$('#error1').html("");
	}
	
    if (id == "1") {
        $("#noticia").show();
        $("#publicidad2").hide();
        $("#foto").hide();
    }

    if (id == "2") {
    	$("#noticia").hide();
        $("#publicidad2").show();
        $("#foto").hide();
    }

    if (id == "3") {
    	$("#noticia").hide();
        $("#publicidad2").hide();
        $("#foto").show();
    }

}

       Date.prototype.yyyymmdd = function() {
	   var yyyy = this.getFullYear().toString();
	   var mm = (this.getMonth()+1).toString(); 
	   var dd  = this.getDate().toString();
	   return yyyy +"-"+ (mm[1]?mm:"0"+mm[0]) +"-"+ (dd[1]?dd:"0"+dd[0]); 
	  };
	  
	  function prepareUpload(event)
	  {
	      alert("Paso..");
	      //document.location.href ='UploadServlet2';
	      //alert("Paso 2");
		  
	  }	  	  
</script>
</head>
<body>
	<h4>Bienvenido <%= (String)request.getParameter("Name") %></h4>
	<hr /> 
	<ul class="nav nav-tabs">
	  <li role="presentation"><a href="http://localhost:8080/jsflab/menu.jsp?Name=<%= (String)request.getParameter("Name") %>">Noticias</a></li>
	  <li role="presentation" class="active"><a href="http://localhost:8080/jsflab/crearNoticia.jsp?Name=<%= (String)request.getParameter("Name") %>">Crear Noticia</a></li>
	  <li role="presentation"><a href="http://localhost:8080/jsflab/usuarios.jsp?Name=<%= (String)request.getParameter("Name") %>">Administradores</a></li>
	</ul>
	<h3>Crear Noticia</h3>
	
	<form action="CrearNoticia" method="post">
    <div class="dropdown">
		  <button class="btn btn-default dropdown-toggle" type="button" id="dropdownMenu1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
		    Seleccionar tipo de Noticia
		    <span class="caret"></span>
		  </button>
		  <ul class="dropdown-menu" aria-labelledby="dropdownMenu1">
		    <li><a href="#" onclick="mostrar('1');">Noticia</a></li>
		    <li><a href="#" onclick="mostrar('2');">Publicidad</a></li>
		    <li><a href="#" onclick="mostrar('3');">Foto Arte</a></li>
		 </ul>
	 </div>
     
	</form>
	
	<div id="noticia" style="display: none;">
	<h3>Ingrese  Noticia</h3>
    <form id='noticia' onsubmit= "return ingresarNoticia()">	   
        <table>  
	    <tr>   
		    <td>Titulo: </td>
		    <td><input id="titulo" name="titulo"  style="WIDTH: 228px" required="required"/></td>
		</tr>
		<tr>
		     <td>Contenido:</td>
		     <td><input id="contenido" name="contenido" style="WIDTH: 228px; HEIGHT: 70px" required="required"/></td>
	     </tr>  
	     <tr>
	       <td>Url Imagen:</td>
		     <td><input id="imagen" name="imagen"  style="WIDTH: 228px" required="required" /></td>
		     <!--  <td><button name="choose" class="btn btn-primary" value="Seleccionar" enable>Seleccionar</button></td>-->

	     </tr>  
	    </table>
	    <br />
	    <button type="submit" class="btn btn-primary" name="crear" value="Crear" >Crear Noticia</button>
    </form>
	</div>
	
	<div id="publicidad2" style="display: none;">
	<h3>Ingrese Publicidad</h3>
    <form id='publicidad2' onsubmit= "return ingresarNoticia()">	
    <table>  
	    <tr>
		     <!--<td>Url Imagen:</td>-->
		      Select a file to upload: <br />
		         <!--  <form action="UploadServlet2" method="post" enctype="multipart/form-data">-->
		         
                <input type="file" name="dataFile" id="fileChooser"/><br/><br/>
                <input type="submit" name="upload" onClick="prepareUpload()" value="Upload" />
		     
		     
		     <!--<td><input id="imagen2" name="imagen2" style="WIDTH: 228px" required="required"/></td>-->
		     <!-- <td><button name="choose2" class="btn btn-primary" value="Seleccionar2" disabled>Seleccionar</button></td>-->
	     </tr>  
	    </table>
	    <br />
	    <button type="submit" class="btn btn-primary" name="crear" value="Crear" >Crear Noticia</button>
    </form>
	</div>
	
	<div id="foto" style="display: none;">
	<h3>Ingrese Foto Arte</h3>
    <form id='foto' onsubmit= "return ingresarNoticia()">	  
	   <table>  
		<tr>
		     <td>Contenido:</td>
		     <td><input id="contenido3" name="contenido3" style="WIDTH: 228px; HEIGHT: 70px" required="required"/></td>
	     </tr>  
	     <tr>
		     <td>Url Imagen:</td>
		     <td><input id="imagen3" name="imagen3"  style="WIDTH: 228px" required="required"/></td>
		     <!-- <td><button name="choose3" class="btn btn-primary" value="Seleccionar3" disabled>Seleccionar</button></td>-->
	     </tr>  
	    </table>
	    <br />
	    <button type="submit" class="btn btn-primary" name="crear" value="Crear">Crear Noticia</button>
    </form>
	</div>
	
	<br />
	<div id='error1'></div>
	<div id='error'></div>
	<hr />
</body>
</html>