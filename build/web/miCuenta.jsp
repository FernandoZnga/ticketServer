<%-- 
    Document   : miCuenta
    Created on : Aug 31, 2018, 9:32:29 AM
    Author     : fernando
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="database.Dba"%>
<%
    if (request.getParameter("btActualizar") != null) {
        try {
            Dba db = new Dba("142.93.245.77:49161:XE");
            db.conectar();
            String qry = "CALL pr_update_users('"
                    + request.getParameter("uuid") + "','"
                    + request.getParameter("firstName") + "','"
                    + request.getParameter("lastName") + "','"
                    + request.getParameter("email") + "')";
//            out.print(qry);
            db.query.execute(qry);
//            out.println("1");
            db.desconectar();
//            out.println("2");
//            request.getRequestDispatcher("main.jsp?exist=2").forward(request, response);
        } catch (Exception e) {
            out.println("3");
            e.printStackTrace();
            out.print(e);
            request.getRequestDispatcher("main.jsp?exist=200").forward(request, response);
        }
    } else if (request.getParameter("editarMicuenta") != null) {
        try {
            Dba db = new Dba("142.93.245.77:49161:XE");
            db.conectar();
            String qry = "SELECT uuid, username, email, firstname, lastname "
                    + "FROM users "
                    + "WHERE username = '" + session.getAttribute("s_username") + "'";
            db.query.execute(qry);
            ResultSet rs = db.query.getResultSet();
            while (rs.next()) {
%>
<div class="container">
    <h2>Mi Cuenta</h2>
    <p><strong>Sección del Usuario.</strong></p>
</div>
<div class="container">
    <div class="row">
        <div class="col-md-8 col-md-offset-2">
            <form name="formMiCuenta" action="main.jsp?exist=2" method="POST">
                <legend class="text-center">Mi Cuenta</legend>
                <fieldset>
                    <div class="form-group col-md-6">
                        <label for="first_name">Nombre</label>
                        <input type="text" class="form-control" name="firstName" id="first_name" placeholder="Nombre" onchange="enableBt()" required value="<%=rs.getString(4)%>">
                    </div>
                    <div class="form-group col-md-6">
                        <label for="last_name">Apellido</label>
                        <input type="text" class="form-control" name="lastName" id="last_name" placeholder="Apellido" onchange="enableBt()" required value="<%=rs.getString(5)%>">
                    </div>

                    <div class="form-group col-md-6">
                        <label for="username">Username</label>
                        <input type="text" class="form-control" name="username" id="first_name" placeholder="Username" disabled required value="<%=rs.getString(2)%>">
                    </div>
                    <div class="form-group col-md-6">
                        <label for="email">Email</label>
                        <input type="text" class="form-control" name="email" id="last_name" placeholder="Email" onchange="enableBt()" required value="<%=rs.getString(3)%>">
                    </div>
                    <div class="form-group col-md-12" hidden>
                        <label for="uuid">uuid</label>
                        <input type="text" class="form-control" name="uuid" id="uuid" placeholder="uuid" required value=<%=rs.getString(1)%>>
                    </div>
                </fieldset>
                <div class="form-group">
                    <div class="col-md-10">
                        <input type="submit" value="Actualizar" name="btActualizar" id="btActualizar" class="btn btn-primary"/>
                        <a href="main.jsp"> Cerrar</a>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
<%
                break;
            }
            db.desconectar();
        } catch (Exception e) {
            e.printStackTrace();
            out.print(e);
        }
    }
%>
