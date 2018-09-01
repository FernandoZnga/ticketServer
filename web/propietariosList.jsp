<%-- 
    Document   : propietariosList
    Created on : Aug 28, 2018, 10:58:42 PM
    Author     : fernando
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="database.Dba"%>
<%            if (request.getParameter("propietarios") != null) {
%>
<div class="container">
    <h2>Propietarios</h2>
    <p><strong>Administración de Propietarios.</strong></p>
</div>
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
                            + "apartamento asc, tipo desc");
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
