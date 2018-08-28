<%-- 
    Document   : index
    Created on : Aug 26, 2018, 2:10:49 PM
    Author     : fernando
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Login Page</title>
<!--        <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
        <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>-->

        <link href="//netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <script src="//netdna.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
        <script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
        <!------ Include the above in your HEAD tag ---------->
    </head>
    <body>
        <%
            if ((request.getParameter("exist") != null)) {

                if (request.getParameter("exist").equals("0")) {
        %>
        <div class="alert alert-warning alert-dismissible show" role="alert">
            <strong>Usuario o Contrasena Incorrectos</strong> Intenta de nuevo.
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
        <%
            }
            if (request.getParameter("exist").equals("100")) {
        %>
        <div class="alert alert-danger alert-dismissible show" role="alert">
            <strong>Error interno</strong> Intenta de nuevo o consulte a su administrador - Error Usr-100.
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
        <%
            }
            if (request.getParameter("exist").equals("101")) {
                session.setAttribute("s_token", null);
            }
            if (request.getParameter("exist").equals("2")) {
        %>
        <div class="alert alert-success alert-dismissible show" role="alert">
            <strong>Solicitud Exitosa</strong> Usuario creado satisfactoriamente, puede proceder a hacer Login.
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
        <%
                }
            if (request.getParameter("exist").equals("3")) {
        %>
        <div class="alert alert-warning alert-dismissible show" role="alert">
            <strong>No tiene sesion activa</strong> Haga Login primero.
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
        <%
                }
            }
        %>
        <div class="container">
            <div class="row">
                <div class="col-md-offset-5 col-md-3">
                    <div class="form-login">
                        <h4>Bienvenido</h4>
                        <form name="loginForm" action="auth.jsp" method="POST">
                            <input type="text" id="userName" name="userName" class="form-control input-sm chat-input" placeholder="username" required/>
                            </br>
                            <input type="password" id="userPassword" name="userPassword" class="form-control input-sm chat-input" placeholder="password" required/>
                            </br>
                            <div class="wrapper">
                                <span class="group-btn">     
                                    <input class="btn btn-primary btn-md" type="submit" value="Login" name="btLogin" />
                                    <a href="newUserForm.jsp"> Eres nuevo? Click aqui</a>
                                </span>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
