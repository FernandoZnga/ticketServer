<%-- 
    Document   : manteList
    Created on : Aug 31, 2018, 10:12:54 PM
    Author     : fernando
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="database.Dba"%>
<%            if (request.getParameter("mantenimientos") != null) {
%>
<div class="container">
    <table class="table table-hover">
        <thead>
            <tr>
                <th>Status</th>
                <th>Zona</th>
                <th>Tipo</th>
                <th>Abierto por</th>
                <th>Asignado a</th>
                <th>Nombre Emp.</th>
                <th>Fecha apertura</th>
                <th>Ultima Actualizacion</th>
            </tr>
        </thead>
        <tbody>
            <%
                try {
                    Dba db = new Dba("142.93.245.77:49161:XE");
                    db.conectar();
                    String qry = "SELECT a.uuid ticketid, a.typeid, a.employeeid, "
                            + "a.statusid, a.createdAt, a.updatedBy, b.status, "
                            + "c.area, c.ttype, c.notes, d.username empusername, "
                            + "d.firstname || ' ' || d.lastname empname, e.username, "
                            + "e.firstname || ' ' || e.lastname uname, d.uuid empid, "
                            + "a.updatedAt FROM mantecomplex a "
                            + "LEFT JOIN ticketstatus b ON a.statusid = b.uuid "
                            + "LEFT JOIN mantetype c ON a.typeid = c.uuid "
                            + "LEFT JOIN users d ON a.employeeid = d.uuid "
                            + "LEFT JOIN users e ON a.updatedBy = e.uuid ORDER BY 16 desc";
                    db.query.execute(qry);
                    ResultSet rs = db.query.getResultSet();
                    while (rs.next()) {
            %>
            <tr>
                <td><%= rs.getString(7)%></td><!--status-->
                <td><%= rs.getString(8)%></td><!--area-->
                <td><%= rs.getString(9)%> - <%= rs.getString(10)%></td><!--tipo + notes-->
                <td><%= rs.getString(13)%></td><!--usuario creó-->
                <td><%= rs.getString(11)%></td> <!--usuario empleado-->
                <td><%= rs.getString(12)%></td><!--asignado a empleado-->
                <td><%= rs.getString(5)%></td><!--createdAt-->
                <td><%= rs.getString(16)%></td><!--updatedAt-->
                <td><a class="btn" data-toggle="modal" 
                       href="manteForm.jsp?manteid=<%= rs.getString(1)%>&fecha=<%= rs.getString(5)%>&zona=<%= rs.getString(8)%>&status=<%= rs.getString(7)%>&statusid=<%= rs.getString(4)%>&tipo=<%= rs.getString(9)%>&subtipo=<%= rs.getString(10)%>&empid=<%= rs.getString(15)%>&asignado=<%= rs.getString(12)%>&editarMante=1">Editar</a></td>                        
            </tr>
            <%
                }
                db.desconectar();
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
