<%-- 
    Document   : propietarios
    Created on : Aug 26, 2018, 11:26:13 PM
    Author     : fernando
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="database.Dba"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="security.jsp"%>

<!DOCTYPE html>
<html>
    <head>
        <title>Usuarios</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    </head>
    <body>
        <jsp:include page="<%= "/header.jsp?tipo=" + session.getAttribute("s_role")%>"  />
        <div class="container">
            <h2>Bienvenido</h2>
            <p>Modulo para la administración de un complejo de apartamentos.</p>
        </div>
        <%
            if (request.getParameter("editarUser") != null) {
        %>
        <div class="container">
            <div class="row">

                <div class="col-md-8 col-md-offset-2">
                    <form role="form" method="POST" action="usuariosForm.jsp?userid=<%=request.getParameter("userid")%>&usernid=<%=request.getParameter("usernid")%>">
                        <legend class="text-center">Editar Usuario</legend>
                        <fieldset>
                            <legend>Datos del Usuario</legend>

                            <div class="form-group col-md-6">
                                <label for="first_name">Nombre</label>
                                <input type="text" class="form-control" name="firstName" id="first_name" placeholder="Nombre" onchange="enableBt()" required value=<%=request.getParameter("fname")%>>
                            </div>
                            <div class="form-group col-md-6">
                                <label for="last_name">Apellido</label>
                                <input type="text" class="form-control" name="lastName" id="last_name" placeholder="Apellido" onchange="enableBt()" required value=<%=request.getParameter("lname")%>>
                            </div>

                            <div class="form-group col-md-4">
                                <label for="username">Username</label>
                                <input type="text" class="form-control" name="username" id="username" placeholder="Username" onchange="enableBt()" disabled required value=<%=request.getParameter("username")%>>
                            </div>
                            <div class="form-group col-md-4">
                                <label for="email">Email</label>
                                <input type="text" class="form-control" name="email" id="email" placeholder="Email" onchange="enableBt()" required value=<%=request.getParameter("mail")%>>
                            </div>
                            <div class="form-group col-md-4">
                                <label for="tipo">Tipo</label><br>
                                <%
                                    if (request.getParameter("tipo").equals("ADMIN")) {
                                %>
                                <input type="radio" id="tipoPropietario" name="tipo" value="ADMIN" checked onchange="enableBt()"/> Administrador
                                <input type="radio" id="tipoInquilino"  name="tipo" value="USUARIO" onchange="enableBt()"/> U. Regular
                                <%
                                } else {
                                %>
                                <input type="radio" id="tipoPropietario"  name="tipo" value="ADMIN" onchange="enableBt()"/> Administrador
                                <input type="radio" id="tipoInquilino"  name="tipo" value="USUARIO" checked onchange="enableBt()"/> U. Regular
                                <%
                                    }
                                %>

                            </div>

                        </fieldset>

                        <div class="form-group">
                            <div class="col-md-10">
                                <input type="submit" value="Actualizar" name="btActualizar" disabled id="btActualizar" class="btn btn-primary"/>
                                <a href="main.jsp?propietarios=1"> Cancelar</a>
                            </div>
                            <div class="col-md-2">
                                <input type="submit" value="Eliminar " name="btEliminar" id="btEliminar" class="btn btn-danger"/>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <%
            }
            if (request.getParameter("btActualizar") != null) {
                try {
                    Dba db = new Dba("142.93.245.77:49161:XE");
                    db.conectar();
                    String qry = "CALL pr_update_user('"
                            + request.getParameter("userid") + "','"
                            + request.getParameter("usernid") + "','"
                            + request.getParameter("email") + "','"
                            + request.getParameter("firstName") + "','"
                            + request.getParameter("lastName") + "','"
                            + request.getParameter("tipo") + "')";
                    out.print(qry);
                    db.query.execute(qry);
                    db.desconectar();
                    request.getRequestDispatcher("main.jsp?usuarios=1").forward(request, response);
                } catch (Exception e) {
                    e.printStackTrace();
                    out.print(e);
                    request.getRequestDispatcher("main.jsp?usuarios=1&exist=200").forward(request, response);
                }
            }
            if (request.getParameter("btEliminar") != null) {
                try {
                    Dba db = new Dba("142.93.245.77:49161:XE");
                    db.conectar();
                    String qry = "CALL pr_delete_user('"
                            + request.getParameter("userid") + "','"
                            + request.getParameter("usernid") + "')";
                    out.print(qry);
                    db.query.execute(qry);
                    db.desconectar();
                    request.getRequestDispatcher("main.jsp?usuarios=1").forward(request, response);
                } catch (Exception e) {
                    e.printStackTrace();
                    out.print(e);
                    request.getRequestDispatcher("main.jsp?usuarios=1&exist=200").forward(request, response);
                }
            }
            if (request.getParameter("agregarUser") != null) {
        %>
        <div class="container">
            <div class="row">

                <div class="col-md-8 col-md-offset-2">
                    <form role="form" method="POST" action="propietariosForm.jsp">
                        <legend class="text-center">Agregar Usuario</legend>
                        <fieldset>
                            <legend>Datos del Usuario</legend>

                            <div class="form-group col-md-6">
                                <label for="first_name">Nombre</label>
                                <input type="text" class="form-control" name="firstName" id="first_name" placeholder="Primer nombre" onchange="enableBtAgregar()" required value="">
                            </div>
                            <div class="form-group col-md-6">
                                <label for="last_name">Apellido</label>
                                <input type="text" class="form-control" name="lastName" id="last_name" placeholder="Apellido" onchange="enableBtAgregar()" required value="">
                            </div>

                            <div class="form-group col-md-4">
                                <label for="username">Username</label>
                                <input type="text" class="form-control" name="username" id="username" placeholder="Username" onchange="enableBtAgregar()" required value="">
                            </div>
                            <div class="form-group col-md-4">
                                <label for="email">Email</label>
                                <input type="text" class="form-control" name="email" id="email" placeholder="Email" onchange="enableBtAgregar()" required value="">
                            </div>
                            <div class="form-group col-md-4">
                                <label for="password">Password</label>
                                <input type="text" class="form-control" name="password" id="password" placeholder="Password" onchange="enableBtAgregar()" required value="">
                            </div>
                            <div class="form-group col-md-12">
                                <label for="tipo">Tipo</label><br>
                                <input required type="radio" id="tipoAdmin" name="tipo" value="ADMIN" onchange="enableBtAgregar()"/> Administrador
                                <input required type="radio" id="tipoUsuario"  name="tipo" value="USUARIO" onchange="enableBtAgregar()"/> Usuario
                            </div>

                        </fieldset>

                        <div class="form-group">
                            <div class="col-md-12">
                                <input type="submit" value="Agregar" name="btAgregar" id="btAgregar" class="btn btn-primary"/>
                                <a href="main.jsp?usuarios=1"> Cancelar</a>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <%
            }
            if (request.getParameter("btAgregar") != null) {
                try {
                    Dba db = new Dba("142.93.245.77:49161:XE");
                    db.conectar();
                    String qry = "CALL pr_insert_newuser('"
                            + request.getParameter("username") + "','"
                            + request.getParameter("password") + "','"
                            + request.getParameter("email") + "','"
                            + request.getParameter("firstName") + "','"
                            + request.getParameter("lastName") + "')";
                    out.print(qry);
                    db.query.execute(qry);
                    db.desconectar();
                    request.getRequestDispatcher("main.jsp?usuarios=1").forward(request, response);
                } catch (Exception e) {
                    e.printStackTrace();
                    out.print(e);
                    request.getRequestDispatcher("main.jsp?usuarios=1&exist=200").forward(request, response);
                }
            }
        %>
        <script>
            function enableBtAgregar() {
                if (document.getElementById("first_name").value.equals("") ||
                        document.getElementById("middle_name").value.equals("") ||
                        document.getElementById("last_name").value.equals("") ||
                        document.getElementById("edificio").value.equals("") ||
                        document.getElementById("apartamento").value.equals("") ||
                        document.getElementById("telefono").value.equals("") ||
                        document.getElementById("email").value.equals("")) {
                    document.getElementById("btAgregar").disabled = true;
                } else {
                    document.getElementById("btAgregar").disabled = false;
                }
                function enableBt() {
                    document.getElementById("btActualizar").disabled = false;
                }
        </script>
    </body>
</html>
