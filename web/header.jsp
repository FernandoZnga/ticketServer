<%-- 
    Document   : header.jsp
    Created on : Aug 28, 2018, 10:15:48 PM
    Author     : fernando
--%>
<nav class="navbar navbar-inverse">
    <div class="container-fluid">
        <div class="navbar-header">
            <a href="main.jsp" class="navbar-brand">Administracion</a>
        </div>
        <ul class="nav navbar-nav">
            <!--<li class="active"><a href="main.jsp">Home</a></li>-->
<%
    if (request.getParameter("tipo").equals("ADMIN")) {
%>
            <li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#">Usuarios <span class="caret"></span></a>
                <ul class="dropdown-menu">
                    <li><a href="main.jsp?reporte=3">Ver Usuarios</a></li>
                    <li><a href="#">Agregar Usuario</a></li>
                </ul>
            </li>
            <li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#">Empleados <span class="caret"></span></a>
                <ul class="dropdown-menu">
                    <li><a href="main.jsp?reporte=3">Ver Empleados</a></li>
                    <li><a href="#">Agregar Empleado</a></li>
                </ul>
            </li>
<%
        }
%>
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
            <li><a href="#">Page 2</a></li>
        </ul>
        <ul class="nav navbar-nav navbar-right">
            <li><a href="#"><span class="glyphicon glyphicon-user"></span> Mi cuenta</a></li>
            <li><a href="index.jsp?exist=101"><span class="glyphicon glyphicon-log-in"></span> Salir</a></li>
        </ul>
    </div>
</nav>
