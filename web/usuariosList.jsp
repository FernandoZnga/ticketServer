<%-- 
    Document   : usuariosList
    Created on : Aug 28, 2018, 11:24:07 PM
    Author     : fernando
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="database.Dba"%>
<%            if (request.getParameter("usuarios") != null) {
%>
<div class="container">
    <h2>Usuarios</h2>
    <p><strong>Mantenimiento de Usuarios.</strong></p>
</div>
<div class="container">
    <table class="table table-hover">
        <thead>
            <tr>
                <th>Usuario</th>
                <th>Nombre</th>
                <th>Apellido</th>
                <th>Email</th>
                <th>Es Admin?</th>
            </tr>
        </thead>
        <tbody>
            <%
                try {
                    Dba db = new Dba("142.93.245.77:49161:XE");
                    db.conectar();
                    db.query.execute("SELECT a.uuid userid, a.username, "
                            + "a.email, a.firstname, a.lastname, "
                            + "b.uuid usernameid, b.USERTYPE "
                            + "FROM  users a, usernames b "
                            + "WHERE a.username = b.username "
                            + "ORDER BY a.username ASC");
                    ResultSet rs = db.query.getResultSet();
                    while (rs.next()) {
            %>

            <tr>
                <td><%= rs.getString(2)%></td><!--Usuario-->
                <td><%= rs.getString(4)%></td><!--Nombre-->
                <td><%= rs.getString(5)%></td><!--Apellido-->
                <td><%= rs.getString(3)%></td><!--Email-->
                <td><%= rs.getString(7)%></td><!--Es Admin-->
                <%
                    if (session.getAttribute("s_username").equals(rs.getString(2))) {
                        out.print("<td><a class=\"btn\" data-toggle=\"modal\" disabled >Editar</a></td>");
                    } else {
                %>
                <td><a class="btn" data-toggle="modal" 
                       href="usuariosForm.jsp?userid=<%= rs.getString(1)%>&usernid=<%= rs.getString(6)%>&username=<%= rs.getString(2)%>&fname=<%= rs.getString(4)%>&lname=<%= rs.getString(5)%>&mail=<%= rs.getString(3)%>&tipo=<%= rs.getString(7)%>&editarUser=1">Editar</a></td>                        
                    <%
                        }
                    %>
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
