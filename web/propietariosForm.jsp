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
        <title>Propietarios</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    </head>
    <body>
        <nav class="navbar navbar-inverse">
            <div class="container-fluid">
                <div class="navbar-header">
                    <a class="navbar-brand">Administracion</a>
                </div>
                <ul class="nav navbar-nav">
                    <li class=""><a href="main.jsp">Home</a></li>
                    <li class="dropdown active"><a class="dropdown-toggle" data-toggle="dropdown" href="#">Propietarios <span class="caret"></span></a>
                        <ul class="dropdown-menu">
                            <li><a href="main.jsp?propietarios=1">Ver Lista de Propietarios</a></li>
                            <li><a href="propietariosForm.jsp?agregarProp=1">Agregar un Proietario</a></li>
                        </ul>
                    </li>
                    <li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#">Mentenimiento <span class="caret"></span></a>
                        <ul class="dropdown-menu">
                            <li><a href="main.jsp?reporte=2">Ver Lista de Mantenimientos</a></li>
                            <li><a href="#">Agregar Mantenimiento</a></li>
                        </ul>
                    </li>
                    <li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#">Reportes <span class="caret"></span></a>
                        <ul class="dropdown-menu">
                            <li><a href="main.jsp?reporte=3">Ver Reportes</a></li>
                            <li><a href="#">Agregar Reporte</a></li>
                        </ul>
                    </li>
                    <li><a href="#">Page 2</a></li>
                </ul>
                <ul class="nav navbar-nav navbar-right">
                    <li><a href="#"><span class="glyphicon glyphicon-user"></span> Mi cuenta</a></li>
                    <li><a href="index.jsp?exist=101"><span class="glyphicon glyphicon-log-in"></span> Salir</a></li>
                </ul>
            </div>
        </nav>

        <div class="container">
            <h3>Bienvenido</h3>
            <p>Modulo para la administración de un complejo de apartamentos.</p>
        </div>
        <%
            if (request.getParameter("editarProp") != null) {
        %>
        <div class="container">
            <div class="row">

                <div class="col-md-8 col-md-offset-2">
                    <form role="form" method="POST" action="propietariosForm.jsp">
                        <legend class="text-center">Editar Propietario</legend>
                        <fieldset>
                            <legend>Datos de Propieario</legend>

                            <div class="form-group col-md-4">
                                <label for="first_name">Primer nombre</label>
                                <input type="text" class="form-control" name="firstName" id="first_name" placeholder="Primer nombre" onchange="enableBt()" required value=<%=request.getParameter("fname")%>>
                            </div>
                            <div class="form-group col-md-4">
                                <label for="middle_name">Segundo nombre</label>
                                <input type="text" class="form-control" name="middleName" id="middle_name" placeholder="Segundo nombre" onchange="enableBt()" required value=<%=request.getParameter("mname")%>>
                            </div>
                            <div class="form-group col-md-4">
                                <label for="last_name">Apellido</label>
                                <input type="text" class="form-control" name="lastName" id="last_name" placeholder="Apellido" onchange="enableBt()" required value=<%=request.getParameter("lname")%>>
                            </div>

                            <div class="form-group col-md-4">
                                <label for="edficio">Edificio</label>
                                <input type="text" class="form-control" name="edificio" id="edificio" placeholder="No. Edificio" onchange="enableBt()" required value=<%=request.getParameter("edifi")%>>
                            </div>
                            <div class="form-group col-md-4">
                                <label for="apartament">Apartamento</label>
                                <input type="text" class="form-control" name="apartamento" id="apartamento" placeholder="No. Apartamento" onchange="enableBt()" required value=<%=request.getParameter("aparto")%>>
                            </div>

                            <div class="form-group col-md-4" hidden>
                                <label for="uuid">uuid</label>
                                <input type="text" class="form-control" name="uuid" id="uuid" placeholder="uuid" onchange="enableBt()" required value=<%=request.getParameter("uuid")%>>
                            </div>

                            <div class="form-group col-md-4">
                                <label for="telefono">Telefono</label>
                                <input type="text" class="form-control" name="telefono" id="telefono" placeholder="Telefono" onchange="enableBt()" required value=<%=request.getParameter("telef")%>>
                            </div>
                            <div class="form-group col-md-4">
                                <label for="email">Email</label>
                                <input type="email" class="form-control" name="email" id="email" placeholder="Email" onchange="enableBt()" required value=<%=request.getParameter("mail")%>>
                            </div>

                            <div class="form-group col-md-4">
                                <label for="tipo">Tipo</label><br>
                                <%
                                    if (request.getParameter("tipo").equals("Propietario")) {
                                %>
                                <input type="radio" id="tipoPropietario" name="tipo" value="Propietario" checked onchange="enableBt()"/> Propietario
                                <input type="radio" id="tipoInquilino"  name="tipo" value="Inquilino" onchange="enableBt()"/> Inquilino
                                <%
                                } else {
                                %>
                                <input type="radio" id="tipoPropietario"  name="tipo" value="Propietario" onchange="enableBt()"/> Propietario
                                <input type="radio" id="tipoInquilino"  name="tipo" value="Inquilino" checked onchange="enableBt()"/> Inquilino
                                <%
                                    }
                                %>
                            </div>

                        </fieldset>

                        <div class="form-group">
                            <div class="col-md-12">
                                <input type="submit" value="Actualizar" name="btActualizar" disabled id="btActualizar" class="btn btn-primary"/>
                                <a href="main.jsp?propietarios=1"> Cancelar</a>
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
                    String qry = "CALL pr_update_propietario('"
                            + request.getParameter("uuid") + "','"
                            + request.getParameter("apartamento") + "','"
                            + request.getParameter("edificio") + "','"
                            + request.getParameter("firstName") + "','"
                            + request.getParameter("middleName") + "','"
                            + request.getParameter("lastName") + "','"
                            + request.getParameter("tipo") + "','"
                            + request.getParameter("telefono") + "','"
                            + request.getParameter("email") + "','"
                            + session.getAttribute("s_username") + "')";
                    out.print(qry);
                    db.query.execute(qry);
                    db.desconectar();
                    request.getRequestDispatcher("main.jsp?propietarios=a").forward(request, response);
                } catch (Exception e) {
                    e.printStackTrace();
                    out.print(e);
                    request.getRequestDispatcher("main.jsp?propietarios=a&exist=200").forward(request, response);
                }
            }
        %>
        <script>
            function enableBt() {
                document.getElementById("btActualizar").disabled = false;
            }
        </script>


        <%
            if (request.getParameter("agregarProp") != null) {
        %>
        <div class="container">
            <div class="row">

                <div class="col-md-8 col-md-offset-2">
                    <form role="form" method="POST" action="propietariosForm.jsp">
                        <legend class="text-center">Agregar Propietario</legend>
                        <fieldset>
                            <legend>Datos de Propieario</legend>

                            <div class="form-group col-md-4">
                                <label for="first_name">Primer nombre</label>
                                <input type="text" class="form-control" name="firstName" id="first_name" placeholder="Primer nombre" onchange="enableBtAgregar()" required value="">
                            </div>
                            <div class="form-group col-md-4">
                                <label for="middle_name">Segundo nombre</label>
                                <input type="text" class="form-control" name="middleName" id="middle_name" placeholder="Segundo nombre" onchange="enableBtAgregar()" required value="">
                            </div>
                            <div class="form-group col-md-4">
                                <label for="last_name">Apellido</label>
                                <input type="text" class="form-control" name="lastName" id="last_name" placeholder="Apellido" onchange="enableBtAgregar()" required value="">
                            </div>

                            <div class="form-group col-md-4">
                                <label for="edficio">Edificio</label>
                                <input type="text" class="form-control" name="edificio" id="edificio" placeholder="No. Edificio" onchange="enableBtAgregar()" required value="">
                            </div>
                            <div class="form-group col-md-4">
                                <label for="apartament">Apartamento</label>
                                <input type="text" class="form-control" name="apartamento" id="apartamento" placeholder="No. Apartamento" onchange="enableBtAgregar()" required value="">
                            </div>

                            <div class="form-group col-md-4">
                                <label for="telefono">Telefono</label>
                                <input type="text" class="form-control" name="telefono" id="telefono" placeholder="Telefono" onchange="enableBtAgregar()" required value="">
                            </div>
                            <div class="form-group col-md-4">
                                <label for="email">Email</label>
                                <input type="email" class="form-control" name="email" id="email" placeholder="Email" onchange="enableBtAgregar()" required value="">
                            </div>

                            <div class="form-group col-md-4">
                                <label for="tipo">Tipo</label><br>
                                <input required type="radio" id="tipoPropietario" name="tipo" value="Propietario" onchange="enableBtAgregar()"/> Propietario
                                <input required type="radio" id="tipoInquilino"  name="tipo" value="Inquilino" onchange="enableBtAgregar()"/> Inquilino
                            </div>

                        </fieldset>

                        <div class="form-group">
                            <div class="col-md-12">
                                <input type="submit" value="Agregar" name="btAgregar" id="btAgregar" class="btn btn-primary"/>
                                <a href="main.jsp?propietarios=1"> Cancelar</a>
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
                    String qry = "CALL pr_insert_newpropietario('"
                            + request.getParameter("apartamento") + "','"
                            + request.getParameter("edificio") + "','"
                            + request.getParameter("firstName") + "','"
                            + request.getParameter("middleName") + "','"
                            + request.getParameter("lastName") + "','"
                            + request.getParameter("tipo") + "','"
                            + request.getParameter("telefono") + "','"
                            + request.getParameter("email") + "','"
                            + session.getAttribute("s_username") + "')";
                    out.print(qry);
                    db.query.execute(qry);
                    db.desconectar();
                    request.getRequestDispatcher("main.jsp?propietarios=a").forward(request, response);
                } catch (Exception e) {
                    e.printStackTrace();
                    out.print(e);
                    request.getRequestDispatcher("main.jsp?propietarios=a&exist=200").forward(request, response);
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
                    document.getElementById("btActualizar").disabled = true;
                } else {
                    document.getElementById("btActualizar").disabled = false;
                }
        </script>
    </body>
</html>
