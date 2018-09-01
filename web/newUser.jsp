<%-- 
    Document   : newUser
    Created on : Aug 26, 2018, 2:49:16 PM
    Author     : fernando
--%>


<%@page import="database.Dba"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%
    if (request.getParameter("username") != null) {
        try {
            Dba db = new Dba("142.93.245.77:49161:XE");
            db.conectar();
            db.query.execute("CALL pr_insert_newuser('"
                    + request.getParameter("username").trim().toUpperCase() + "','"
                    + request.getParameter("password1") + "','"
                    + request.getParameter("email") + "','"
                    + request.getParameter("firstName") + "','"
                    + request.getParameter("lastName") + "','"
                    + "USUARIO')");

            db.desconectar();
            request.getRequestDispatcher("index.jsp?exist=2").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            out.print(e);
            request.getRequestDispatcher("index.jsp?exist=100").forward(request, response);
        }
    } else {
        request.getRequestDispatcher("index.jsp?exist=3").forward(request, response);
    }
%>
