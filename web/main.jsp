<%-- 
    Document   : main
    Created on : Aug 26, 2018, 12:55:28 PM
    Author     : fernando
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="database.Dba"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    //seguridad de la pagina
    if (session.getAttribute("s_token") == null) {
        request.getRequestDispatcher("index.jsp?exist=3").forward(request, response);
    } else if (session.getAttribute("s_token") != null) {
        Dba db = new Dba("142.93.245.77:49161:XE");
        db.conectar();
        db.query.execute("SELECT valid "
                + "FROM usertoken "
                + "WHERE token ='" + session.getAttribute("s_token") + "' "
                + "AND valid = 1");
        ResultSet rs = db.query.getResultSet();
        while (rs.next()) {
            if (rs.getString(1).equals("1")) {
                break;
            } else {
                request.getRequestDispatcher("index.jsp?exist=3").forward(request, response);
            }
        }
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <title>Pagina Principal</title>
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
                    <li class="active"><a href="main.jsp">Home</a></li>
                    <li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#">Propietarios <span class="caret"></span></a>
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
        <%
            if ((request.getParameter("exist") != null)) {

                if (request.getParameter("exist").equals("200")) {
        %>
        <div class="alert alert-warning alert-dismissible show" role="alert">
            <strong>No se actualizó el registros</strong> Asegurese de ingresar datos válidos.
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
        <%
            }
        }
        %>
        <div class="container">
            <h2>Bienvenido</h2>
            <p><strong>Modulo para la administración de un complejo de apartamentos.</strong></p>
        </div>
        <%            if (request.getParameter("propietarios") != null) {
        %>
        <div class="container">
            <table class="table table-hover">
                <thead>
                    <tr>
                        <th>Edificio</th>
                        <th>Apartamento</th>
                        <th>Apellido</th>
                        <th>Nombre</th>
                        <th>Telefono</th>
                        <th>Email</th>
                        <th>Es Propietario?</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        try {
                            Dba db = new Dba("142.93.245.77:49161:XE");
                            db.conectar();
                            db.query.execute(
                                    "SELECT uuid, apartamento, edificio, firstname, middlename, "
                                    + "lastname, tipo, telefono, email, username "
                                    + "FROM propietarios "
                                    + "ORDER BY edificio asc, "
                                    + "apartamento asc, tipo desc, lastname, "
                                    + "firstname");
                            ResultSet rs = db.query.getResultSet();
                            while (rs.next()) {
                    %>

                    <tr>
                        <td><%= rs.getString(3)%></td><!--edifico-->
                        <td><%= rs.getString(2)%></td><!--apartamento-->
                        <td><%= rs.getString(6)%></td><!--apellido-->
                        <td><%= rs.getString(4)%></td><!--nombre-->
                        <td><%= rs.getString(8)%></td><!--telefono-->
                        <td><%= rs.getString(9)%></td><!--email-->
                        <td><%= rs.getString(7)%></td><!--tipo-->
                        <td><a class="btn" data-toggle="modal" 
                               href="propietariosForm.jsp?aparto=<%= rs.getString(2)%>&edifi=<%= rs.getString(3)%>&lname=<%= rs.getString(6)%>&fname=<%= rs.getString(4)%>&mname=<%= rs.getString(5)%>&telef=<%= rs.getString(8)%>&mail=<%= rs.getString(9)%>&tipo=<%= rs.getString(7)%>&uuid=<%= rs.getString(1)%>&uname=<%= session.getAttribute("s_username")%>&editarProp=1">Editar</a></td>
                    </tr>
                    <%
                        }
                    %>

                </tbody>
            </table>
        </div>
        <%
                } catch (Exception e) {
                    e.printStackTrace();
                    out.print(e);
                }
            }
        %>
    </body>
</html>
