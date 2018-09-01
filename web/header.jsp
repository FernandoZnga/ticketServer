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
            <li class="dropdown"><a class="dropdown-toggle active" data-toggle="dropdown" href="#">Usuarios<span class="caret"></span></a>
                <ul class="dropdown-menu">
                    <li><a href="main.jsp?usuarios=1">Listar Usuarios</a></li>
                    <li><a href="usuariosForm.jsp?agregarUser=1">Agregar Usuario</a></li>
                </ul>
            </li>
            <li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#">Propietarios<span class="caret"></span></a>
                <ul class="dropdown-menu">
                    <li><a href="main.jsp?propietarios=1">Listar Propietarios</a></li>
                    <li><a href="propietariosForm.jsp?agregarProp=1">Agregar Proietario</a></li>
                </ul>
            </li>
<%
        }
%>
            <li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#">Tickets<span class="caret"></span></a>
                <ul class="dropdown-menu">
                    <li><a href="main.jsp?tickets=1">Listar Tickets</a></li>
                    <li><a href="ticketsForm.jsp?areaType=1&agregarTicket=1">Agregar Ticket</a></li>
                </ul>
            </li>
            <li><a href="#">Page 2</a></li>
        </ul>
        <ul class="nav navbar-nav navbar-right">
            <li><a href="main.jsp?editarMicuenta=1"><span class="glyphicon glyphicon-user"></span> Mi cuenta <%=session.getAttribute("s_username")%></a></li>
            <li><a href="index.jsp?exist=101"><span class="glyphicon glyphicon-log-in"></span> Salir</a></li>
        </ul>
    </div>
</nav>
