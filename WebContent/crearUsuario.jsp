<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Crear Administrador</title>
<script src="//ajax.googleapis.com/ajax/libs/jquery/2.2.0/jquery.min.js" ></script>
<link href="css/bootstrap.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="js/bootstrap.min.js" ></script>
<script>
<%
HttpSession objSesion = request.getSession(false); 
String usuario = (String)objSesion.getAttribute("usuario");
String usuario2= (String)request.getParameter("Name");

if (usuario2==null){
response.sendRedirect("login.jsp");
}
else{
	//out.println("Usuario en sesion con datos:usuario " + usuario);
	//out.println("Usuario en sesion :" + usuario2); 
    }
%>
function buscarUsuario(){
	if(document.getElementById('correo').value){
		var correo = document.getElementById('correo').value;    	
		$.ajax({
			url:"http://localhost:8080/fimi_v1/webapi/u/getAdmin;correo="+correo,
	        type:'get',
	        dataType: 'json',
	        success: function(data) {
	            if(data.cod_salida == 0){	            	
            		if(data.correo == correo){	      
            			$('#error1').html("");
            			$('#nombre').val(data.nombre);
            			$('#correo2').val(data.correo);
            			$('#clave').val(data.contrasena);            			
            		}                	
	            }
	            else{
	            	$('#error1').html("");
	            	$('#error1').html("<div class='alert alert-danger' role='alert'><span class='glyphicon glyphicon-exclamation-sign' aria-hidden='true'></span><span class='sr-only'>Error:</span> No existe usuario con el mail ingresado</div>");
	                
	            }                	
	        },
	        error: function(e) {
	        	console.log(e.message);
	        }
	    });
	}
	else{	
			$('#error1').html(""); 
			$('#error1').html("<div class='alert alert-warning' role='alert'><span class='glyphicon glyphicon-exclamation-sign' aria-hidden='true'></span><span class='sr-only'>Error:</span> Debe completar todos los campos</div>");
	      
		}

    return false;		
}

function guardarUsuario(){
	var user = ' <%= (String)request.getParameter("Name") %>';
	
	if(document.getElementById('nombre').value && document.getElementById('correo2').value && document.getElementById('clave').value){
		var nombre = document.getElementById('nombre').value;
		var correo = document.getElementById('correo2').value;
		var clave = document.getElementById('clave').value;
		
		 $.ajax({		        
		        url:"http://localhost:8080/fimi_v1/webapi/u/setAdmin;correo="+correo+";pass="+clave+";nom="+nombre+";estado=0",
		        type:'post',
		        dataType: 'json',
		        success: function(data) {
		            if(data.cod_salida == 0){
		            	$('#error').html("");
		            	$('#error1').html("<div class='alert alert-success' role='alert'>Administrador creado exitosamente</div>");
		            }
		            else{
		            	$('#error').html("");
		            	$('#error1').html("<div class='alert alert-danger' role='alert'><span class='glyphicon glyphicon-exclamation-sign' aria-hidden='true'></span><span class='sr-only'>Error:</span> Usuario ya existe como administrador</div>");
		            }                	
		        },
		        error: function(e) {
		        	console.log(e.message);
		        }
		    });
		    
		
	}
	else{		
			$('#error1').html("<div class='alert alert-warning' role='alert'><span class='glyphicon glyphicon-exclamation-sign' aria-hidden='true'></span><span class='sr-only'>Error:</span> Debe completar todos los campos</div>");
  	}

    return false;	
}

function mostrar(id) {
	
	if($('#error').html() != ""){
		$('#error').html("");
	}	
}	

</script>
</head>
<body>
	<h4>Bienvenido <%= (String)request.getParameter("Name") %></h4>
	<hr /> 
		
     <ul class="nav nav-tabs">
	  <li role="presentation"><a href="http://localhost:8080/jsflab/menu.jsp?Name=<%= (String)request.getParameter("Name") %>">Noticias</a></li>
	  <li role="presentation" ><a href="http://localhost:8080/jsflab/crearNoticia.jsp?Name=<%= (String)request.getParameter("Name") %>">Crear Noticia</a></li>
	  <li role="presentation" class="active"><a href="http://localhost:8080/jsflab/usuarios.jsp?Name=<%= (String)request.getParameter("Name") %>">Administradores</a></li>
	</ul>
	
	<ul class="nav nav-tabs">
	  <li role="presentation"><a href="http://localhost:8080/jsflab/usuarios.jsp?Name=<%= (String)request.getParameter("Name") %>">Lista Administradores</a></li>
	  <li role="presentation" class="active"><a href="http://localhost:8080/jsflab/crearUsuario.jsp?Name=<%= (String)request.getParameter("Name") %>">Crear Administrador</a></li>
	</ul>
	
	<h3>Crear Administrador</h3>
	<table>  
		 <div class="form-group">
	    		<td><label for="exampleInputEmail1">Correo de usuario </label></td>
	    		<td><input type="email" class="form-control" id="correo" name ="user1" placeholder="Email" required="required"></td>
	    		<td><button onclick = 'return buscarUsuario()' class="btn btn-primary" name="buscar" value="buscar">Buscar</button></td>
 			</div>	
	</table>
	     <br />
	     <form id='buscarUsuario' onsubmit= "return guardarUsuario()">
	     <table> 
	     <tr> 
		    <div class="form-group">
	    		<td><label for="exampleInputEmail1">Nombre</label>
	    		<input type="text" class="form-control" id="nombre" name="nombre" DISABLED></td>
 			</div>		    
		</tr>
		</table> 
		<table> 
	     <tr> 
		    <div class="form-group">
	    		<td><label for="exampleInputEmail1">Correo electrónico</label>
	    		<input type="text" class="form-control" id="correo2" name="correo2" DISABLED></td>
 			</div>		    
		</tr>
		</table>
		<table> 
		<tr> 
		    <div class="form-group">
	    		<td><label for="exampleInputEmail1">Contraseña</label>
	    		<input type="password" class="form-control" id="clave" name="clave" DISABLED></td>
 			</div>		    
	     </tr>  	
	     </table>
	    <br />
	   
	    <button type = 'submit' class="btn btn-primary"  name="guardar" value="guardar">Crear</button> 
    </form>

	<br />
	<div id='error1'></div>
	<hr />
	
</body>
</html>