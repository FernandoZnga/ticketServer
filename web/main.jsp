<%-- 
    Document   : main
    Created on : Aug 26, 2018, 12:55:28 PM
    Author     : fernando
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="database.Dba"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@include file="security.jsp"%>
<%--<%@include file="header.jsp"%>--%>
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
        <jsp:include page="<%= "/header.jsp?tipo="+session.getAttribute("s_role") %>"  />
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
