<%-- 
    Document   : auth
    Created on : Aug 26, 2018, 12:43:15 PM
    Author     : fernando
--%>


<%@page import="database.Dba"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%
    if (request.getParameter("userName") != null) {
        try {
            Dba db = new Dba("142.93.245.77:49161:XE");
            db.conectar();
            db.query.execute(
                    "SELECT uuid, username, password"
                    + " FROM usernames");
            ResultSet rs1 = db.query.getResultSet();
            String centinela = "n";
            while (rs1.next()) {
                if (request.getParameter("userName").trim().toUpperCase().equals(rs1.getString(2).toUpperCase())
                        && request.getParameter("userPassword").equals(rs1.getString(3))) {
                    centinela = "s";
                    break;
                }
            }
            if (centinela.equals("s")) {
                db.query.execute("CALL pr_user_token('"
                        + request.getParameter("userName").trim().toUpperCase() + "')");
                out.println("9");
                db.query.execute("SELECT token "
                        + "FROM usertoken "
                        + "WHERE username ='" + request.getParameter("userName").trim().toUpperCase() + "' "
                                + "AND valid = 1");
                ResultSet rs2 = db.query.getResultSet();
                while (rs2.next()) {
                    session.setAttribute("s_token", rs2.getString(1));
                    break;
                }
                session.setAttribute("s_username",request.getParameter("userName").trim().toUpperCase());
                out.println(session.getAttribute("s_token"));
                request.getRequestDispatcher("main.jsp").forward(request, response);
            } else {
//            out.print("<script>alert('el usuario no existe')</script>");
//            out.print("1");
                request.getRequestDispatcher("index.jsp?exist=0").forward(request, response);
            }
            db.desconectar();
        } catch (Exception e) {
            e.printStackTrace();
            out.print(e);
        }
    } else {
        request.getRequestDispatcher("index.jsp?exist=3").forward(request, response);
    }
%>
