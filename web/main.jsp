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
        <jsp:include page="<%= "/header.jsp?tipo=" + session.getAttribute("s_role") %>"  />
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
        <jsp:include page="/propietariosList.jsp" />
        <jsp:include page="/usuariosList.jsp" />
        <jsp:include page="/ticketsList.jsp" />
    </body>
</html>
