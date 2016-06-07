<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page session="true"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Login</title>
<script src="//ajax.googleapis.com/ajax/libs/jquery/2.2.0/jquery.min.js" ></script>
<link href="css/bootstrap.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="js/bootstrap.min.js" ></script>

<%
HttpSession objSesion = request.getSession(true);
//HttpSession sesion = request.getSession();
//out.println("IdSesion: "+sesion.getId());
String user = "nombre usuario"; 
objSesion.setAttribute("usuario", user);
out.println("Poniendo usuario en sesion ...");
%>

<script>

function ValidarLogin(){	
	
    	var correo = document.getElementById('usuario').value;
    	var pass = document.getElementById('password').value;
    	//serverRoot = "http://192.168.30.206:7010/fimi_v1";
    	//serverRoot2 = "http://192.168.30.206:7010/jsflab";
        $.ajax({        
            url:"http://localhost:8080/fimi_v1/webapi/u/login;correo="+correo+";pass="+pass,
            type:'get',
            dataType: 'json',
            success: function(data) {
                if(data.cod_salida == 0){
                	window.location = "http://localhost:8080/jsflab/menu.jsp?Name="+data.nombre;
                }
                else{
                	$('#error1').html("");
                	$('#error1').html("<div class='alert alert-danger' role='alert'><span class='glyphicon glyphicon-exclamation-sign' aria-hidden='true'></span><span class='sr-only'>Error:</span> Correo electrónico o clave incorrecta</div>");
                }               	
            },
            error: function(e) {
            	console.log(e.message);
            }
        });        
        return false;
};
</script>
</head>
<body>

	<h2>Login</h2> 
	<form id='login'  onsubmit= "return ValidarLogin()">	   
	   <table>  	  
	    <tr> 
		    <div class="form-group">
	    		<td><label for="exampleInputEmail1">Correo electrónico</label>
	    		<input type="email" class="form-control" id="usuario" placeholder="Email" name ="user" required="required"></td>
 			</div>		    
		</tr>
		</table> 
		<table> 
		<tr> 
		    <div class="form-group">
	    		<td><label for="exampleInputEmail1">Contraseña</label>
	    		<input type="password" class="form-control" id="password" placeholder="Password" name ="pass" required="required"></td>
 			</div>		    
	     </tr>   
	    </table>
	    <br />
	    <button type="submit" class="btn btn-primary" name="button" value="Ingresar">Ingresar</button>	
	    <br /><br /><hr />
    </form>
    <div id='error1'></div>
</body>
</html>