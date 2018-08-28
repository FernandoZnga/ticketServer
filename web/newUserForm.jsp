<%-- 
    Document   : newUser
    Created on : Aug 26, 2018, 2:43:21 PM
    Author     : fernando
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
        <script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
        <title>Nuevo Usuario</title>
        <script>
            var checkPass = function () {
                if (document.getElementById('password1').value ===
                        document.getElementById('password2').value) {
                    if (document.getElementById('password1').value !== "") {
                        document.getElementById('message').style.color = 'green';
                        document.getElementById('message').innerHTML = ' Concuerda';
                        document.getElementById('btSubmit').disabled = false;
                    }
                } else {
                    document.getElementById('message').style.color = 'red';
                    document.getElementById('message').innerHTML = ' No concuerda';
                    document.getElementById('btSubmit').disabled = true;
                }
            };

        </script>
    </head>
    <body>
        <div class="container">
            <div class="row">

                <div class="col-md-8 col-md-offset-2">
                    <form role="form" method="POST" action="newUser.jsp">
                        <legend class="text-center">Registro</legend>
                        <fieldset>
                            <legend>Datos de Cuenta</legend>

                            <div class="form-group col-md-6">
                                <label for="first_name">Primer nombre</label>
                                <input type="text" class="form-control" name="firstName" id="first_name" placeholder="Primer nombre" required>
                            </div>

                            <div class="form-group col-md-6">
                                <label for="last_name">Apellidos</label>
                                <input type="text" class="form-control" name="lastName" id="last_name" placeholder="Apellidos" required>
                            </div>

                            <div class="form-group col-md-6">
                                <label for="username">Nombre de usuario</label>
                                <input type="text" class="form-control" name="username" id="username" placeholder="Username" required>
                            </div>

                            <div class="form-group col-md-6">
                                <label for="email">Email</label>
                                <input type="email" class="form-control" name="email" id="email" placeholder="Email" required>
                            </div>

                            <div class="form-group col-md-6">
                                <label for="password1">Contrasena</label>
                                <input type="password" class="form-control" name="password1" id="password1" placeholder="Contrasena" required onkeyup='checkPass();'>
                            </div>

                            <div class="form-group col-md-6">
                                <label for="password2">Confirmar contrasena</label><span id='message'></span>
                                <input type="password" class="form-control" name="password2" id="password2" placeholder="Confirme Contrasena" required onkeyup='checkPass();'>
                            </div>
                        </fieldset>

                        <div class="form-group">
                            <div class="col-md-12">
                                <input type="submit" value="Registrar" name="btSubmit" disabled id="btSubmit" class="btn btn-primary"/>
                                <a href="index.jsp">Ya tienes una cuenta?</a>
                            </div>
                        </div>
                    </form>
                </div>

            </div>
        </div>
    </body>
</html>
