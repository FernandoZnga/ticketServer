<%-- 
    Document   : manteForm
    Created on : Aug 31, 2018, 10:15:16 PM
    Author     : fernando
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="database.Dba"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="security.jsp"%>

<!DOCTYPE html>
<html>
    <head>
        <title>Tickets</title>
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
            if (request.getParameter("editarMante") != null) {
        %>
        <div class="container">
            <div class="row">
                <div class="col-md-8 col-md-offset-2">
                    <form role="form" method="POST" action="manteForm.jsp?manid=<%=request.getParameter("manteid")%>">
                        <legend class="text-center">Editar Mantenimiento</legend>
                        <fieldset>
                            <legend>Editar Mantenimiento</legend>

                            <div class="form-group col-md-4">
                                <label for="zona">Zona</label>
                                <input type="text" class="form-control" name="zona" id="area" placeholder="Zona" disabled required value=<%=request.getParameter("zona")%>>
                            </div>
                            <div class="form-group col-md-8">
                                <label for="tipo mantenimiento">Tipo Mantenimiento</label>
                                <input type="text" class="form-control" name="tipoMantenimiento" id="tipoReporte" placeholder="Tipo Mantenimiento" disabled required value="<%=request.getParameter("tipo")%> <%=request.getParameter("subtipo")%>">
                            </div>
                            <div class="form-group col-md-6">
                                <label for="fecha">Fecha Apertura</label>
                                <input type="text" class="form-control" name="fecha" id="fecha" placeholder="Fecha" disabled required value=<%=request.getParameter("fecha")%>>
                            </div>

                            <div class="form-group col-md-6">
                                <label for="status">Status</label><br>
                                <%
                                    if (request.getParameter("status").equals("ABIERTO")) {
                                %>
                                <input type="radio" id="tipoAbierto" name="tipo" value="ABIERTO" checked /> Abierto
                                <input type="radio" id="tipoCerrado"  name="tipo" value="CERRADO" onchange="enableBt()"/> Cerrado
                                <input type="radio" id="tipoCerrado"  name="tipo" value="RETENIDO" onchange="enableBt()"/> Retenido
                                <%
                                } else if (request.getParameter("status").equals("CERRADO")) {
                                %>
                                <input type="radio" id="tipoAbierto" name="tipo" value="ABIERTO" onchange="enableBt()"/> Abierto
                                <input type="radio" id="tipoCerrado"  name="tipo" value="CERRADO" checked /> Cerrado
                                <input type="radio" id="tipoCerrado"  name="tipo" value="RETENIDO" onchange="enableBt()"/> Retenido
                                <%
                                } else {
                                %>
                                <input type="radio" id="tipoAbierto" name="tipo" value="ABIERTO" onchange="enableBt()"/> Abierto
                                <input type="radio" id="tipoCerrado"  name="tipo" value="CERRADO" onchange="enableBt()"/> Cerrado
                                <input type="radio" id="tipoCerrado"  name="tipo" value="RETENIDO" checked /> Retenido
                                <%
                                    }
                                %>
                            </div>

                            <div class="form-group col-md-12">
                                <label for="email">Asignado a:</label>
                                <select name="asignadoA" class="form-control" id="asignadoA" required onchange="enableBt()">
                                    <option id="default" name="default" value="default" disabled>Escoja una opcion</option>
                                    <%
                                        try {
                                            Dba db = new Dba("142.93.245.77:49161:XE");
                                            db.conectar();
                                            String qry = "SELECT a.uuid, a.firstname ||' '|| a.lastname, b.username "
                                                    + "FROM users a, usernames b "
                                                    + "WHERE a.username = b.username "
                                                    + "AND b.usertype = 'USUARIO' "
                                                    + "ORDER BY 2";
                                            db.query.execute(qry);
                                            ResultSet rs = db.query.getResultSet();
                                            while (rs.next()) {
                                                if (rs.getString(1).equals(request.getParameter("empid"))) {
                                    %>
                                    <option name="asignadoA" value="<%=rs.getString(1)%>" selected ><%=rs.getString(3)%></option> 
                                    <%
                                    } else {
                                    %>
                                    <option name="asignadoA" value="<%=rs.getString(1)%>" ><%=rs.getString(3)%></option> 
                                    <%
                                                }
                                            }
                                            db.desconectar();
                                        } catch (Exception e) {
                                            e.printStackTrace();
                                            out.print(e);
                                        }
                                    %>
                                </select>
                            </div>
                            <div class="form-group col-md-4" hidden>
                                <label for="manid">uuid</label>
                                <input type="text" class="form-control" name="manteid" id="ticid" placeholder="manteid" disabled required value="<%=request.getParameter("manteid")%>">
                            </div>
                            <div class="form-group col-md-12">
                                <label for="comment">Historial de Comentarios</label>
                                <%
                                    try {
                                        Dba db = new Dba("142.93.245.77:49161:XE");
                                        db.conectar();
                                        String qry = "SELECT a.createdAt, notes, "
                                                + "firstname || ' ' || lastname empname "
                                                + "FROM comments a, users b "
                                                + "WHERE a.employeeid = b.uuid "
                                                + "AND a.ticketid = '" + request.getParameter("manteid") + "' "
                                                + "ORDER BY 1 desc";
                                        db.query.execute(qry);
                                        ResultSet rs = db.query.getResultSet();
                                        while (rs.next()) {
                                %>
                                <br><%=rs.getString(1)%><textarea class="form-control" rows="2" id="comment" name="comment" required disabled ><%=rs.getString(3)%>&#13;&#10;<%=rs.getString(2)%></textarea>
                                <%
                                        }
                                        db.desconectar();
                                    } catch (Exception e) {
                                        e.printStackTrace();
                                        out.print(e);
                                    }
                                %>
                            </div>
                        </fieldset>

                        <div class="form-group">
                            <div class="col-md-10">
                                <input type="submit" value="Actualizar" name="btActualizar" disabled id="btActualizar" class="btn btn-primary"/>
                                <a href="main.jsp?mantenimientos=1"> Cancelar</a>
                            </div>
                            <div class="col-md-2">
                                <input type="submit" value="Eliminar " name="btEliminar" id="btEliminar" class="btn btn-danger"/>
                            </div>
                        </div>
                    </form>
                    <div class="container-fluid">
                        <br><br>
                        <button class="btn btn-success" onclick="agregarComentario()">Agregar Comentario</button>
                    </div>
                </div>
            </div>
        </div>
        <%            }
            if (request.getParameter("agregarMantenimiento") != null) {
        %>
        <div class="container">
            <div class="row">

                <div class="col-md-8 col-md-offset-2">
                    <form role="form" method="POST" action="manteForm.jsp?agregarMantenimiento=1">
                        <legend class="text-center">Agregar Mantenimiento</legend>
                        <fieldset>
                            <legend>Datos del Mantenimiento</legend>
                            <div class="form-group col-md-4">
                                <label for="zona">Zona</label>
                                <select name="ddZona" class="form-control" required onchange="this.form.submit()">
                                    <option id="default" name="" value="" selected disabled>Escoja una opcion</option>
                                    <%
                                        try {
                                            Dba db = new Dba("142.93.245.77:49161:XE");
                                            db.conectar();
                                            String qry = "SELECT DISTINCT area "
                                                    + "FROM mantetype "
                                                    + "ORDER BY 1";
                                            db.query.execute(qry);
                                            ResultSet rs = db.query.getResultSet();
                                            while (rs.next()) {
                                                if (request.getParameter("ddZona") != null
                                                        && request.getParameter("ddZona").equals(rs.getString(1))) {
                                    %>
                                    <option id="area" name="ddZona" value="<%=rs.getString(1)%>" selected required><%=rs.getString(1)%></option>    
                                    <%
                                    } else {
                                    %>
                                    <option id="area" name="ddZona" value="<%=rs.getString(1)%>" required><%=rs.getString(1)%></option>    
                                    <%
                                                }
                                            }
                                            db.desconectar();
                                        } catch (Exception e) {
                                            e.printStackTrace();
                                            out.print(e);
                                        }
                                    %>
                                </select>
                            </div>
                            <div class="form-group col-md-8">
                                <label for="tipo reporte">Tipo Reporte</label>
                                <select name="ddReporte" class="form-control" required onchange="enableBtAgregar()">
                                    <option id="default" name="" value="" selected disabled>Escoja una opcion</option>
                                    <%
                                        if (request.getParameter("ddZona") != null) {
                                            try {
                                                Dba db = new Dba("142.93.245.77:49161:XE");
                                                db.conectar();
                                                String qry = "SELECT ttype || ' - ' || notes, uuid "
                                                        + "FROM mantetype "
                                                        + "WHERE area = '" + request.getParameter("ddZona") + "' "
                                                        + "ORDER BY 1";
                                                db.query.execute(qry);
                                                ResultSet rs = db.query.getResultSet();
                                                while (rs.next()) {
                                                    if (request.getParameter("ddReporte") != null
                                                            && request.getParameter("ddReporte").equals(rs.getString(1))) {
                                    %>
                                    <option id="area" name="ddReporte" value="<%=rs.getString(2)%>" selected required><%=rs.getString(1)%></option>    
                                    <%
                                    } else {
                                    %>
                                    <option id="area" name="ddReporte" value="<%=rs.getString(2)%>" required><%=rs.getString(1)%></option>    
                                    <%
                                                    }
                                                }
                                                db.desconectar();
                                            } catch (Exception e) {
                                                e.printStackTrace();
                                                out.print(e);
                                            }
                                        }
                                    %>
                                </select>
                            </div>
                            <div class="form-group col-md-12">
                                <label for="email">Asignado a:</label>
                                <select name="asignadoB" class="form-control" id="asignadoA" required onchange="enableBtAgregar()">
                                    <option id="default" name="default" value="" selected disabled>Escoja una opcion</option>
                                    <%
                                        try {
                                            Dba db = new Dba("142.93.245.77:49161:XE");
                                            db.conectar();
                                            String qry = "SELECT a.uuid, a.firstname ||' '|| a.lastname, b.username "
                                                    + "FROM users a, usernames b "
                                                    + "WHERE a.username = b.username "
                                                    + "AND b.usertype = 'USUARIO' "
                                                    + "ORDER BY 2";
                                            db.query.execute(qry);
                                            ResultSet rs = db.query.getResultSet();
                                            while (rs.next()) {
                                                if (request.getParameter("asignadoB") != null
                                                        && rs.getString(1).equals(request.getParameter("asignadoB"))) {
                                    %>
                                    <option name="asignadoB" value="<%=rs.getString(1)%>" selected required ><%=rs.getString(2)%></option> 
                                    <%
                                    } else {
                                    %>
                                    <option name="asignadoB" value="<%=rs.getString(1)%>" required ><%=rs.getString(2)%></option> 
                                    <%
                                                }
                                            }
                                            db.desconectar();
                                        } catch (Exception e) {
                                            e.printStackTrace();
                                            out.print(e);
                                        }
                                    %>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="comment">Agregue un Comentario</label>
                                <%
                                    if (request.getParameter("comment") != null) {
                                %>
                                <textarea class="form-control" rows="5" id="comment" name="comment" required ><%=request.getParameter("comment")%></textarea>
                                <%
                                } else {
                                %>
                                <textarea class="form-control" rows="5" id="comment" name="comment" required ></textarea>
                                <%}%>
                            </div>

                        </fieldset>

                        <div class="form-group">
                            <div class="col-md-10">
                                <input type="submit" value="Agregar" name="btAgregar" id="btAgregar" class="btn btn-primary"/>
                                <a href="main.jsp?mantenimientos=1"> Cancelar</a>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <%
            }
        %>



        <%
            if (request.getParameter("btActualizar") != null) {
                try {
                    Dba db = new Dba("142.93.245.77:49161:XE");
                    db.conectar();
                    String qry = "CALL pr_update_mantecomplex('"
                            + request.getParameter("manid") + "','"
                            + request.getParameter("asignadoA") + "','"
                            + request.getParameter("tipo") + "')";
                    out.print(qry);
                    db.query.execute(qry);
                    db.desconectar();
                    request.getRequestDispatcher("main.jsp?mantenimientos=1").forward(request, response);
                } catch (Exception e) {
                    e.printStackTrace();
                    out.print(e);
                    request.getRequestDispatcher("main.jsp?mantenimientos=1&exist=200").forward(request, response);
                }
            }
            if (request.getParameter("btEliminar") != null) {
                try {
                    Dba db = new Dba("142.93.245.77:49161:XE");
                    db.conectar();
                    String qry = "CALL pr_delete_mantecomplex('"
                            + request.getParameter("manid") + "')";
                    out.print(qry);
                    db.query.execute(qry);
                    db.desconectar();
                    request.getRequestDispatcher("main.jsp?mantenimientos=1").forward(request, response);
                } catch (Exception e) {
                    e.printStackTrace();
                    out.print(e);
                    request.getRequestDispatcher("main.jsp?mantenimientos=1&exist=200").forward(request, response);
                }
            }
            if (request.getParameter("btAgregar") != null) {
                try {
                    Dba db = new Dba("142.93.245.77:49161:XE");
                    db.conectar();
                    String qry = "CALL pr_insert_newmantecomplex('"
                            + request.getParameter("ddReporte") + "','"
                            + request.getParameter("asignadoB") + "','"
                            + "eGjArrVBvzEPpjOmoTxn" + "','"
                            + session.getAttribute("s_username") + "','"
                            + request.getParameter("comment") + "')";
                    db.query.execute(qry);
                    db.desconectar();
                    request.getRequestDispatcher("main.jsp?mantenimientos=1").forward(request, response);
                } catch (Exception e) {
                    e.printStackTrace();
                    out.print(e);
                    request.getRequestDispatcher("main.jsp?mantenimientos=1&exist=200").forward(request, response);
                }
            }
        %>

        <script>
            function enableBt() {
                document.getElementById("btActualizar").disabled = false;
            }
            function enableBtAgregar() {
                if (document.getElementById("ddReporte").value.equals("") ||
                        document.getElementById("asignadoB").value.equals("")
                        ) {
                    document.getElementById("btAgregar").disabled = true;
                } else {
                    document.getElementById("btAgregar").disabled = false;
                }
            }
            function    agregarComentario() {
                window.open("newComment.jsp?ticket=<%=request.getParameter("manteid")%>", "pageName", "height=600,width=600");
            }
        </script>
    </body>
</html>
