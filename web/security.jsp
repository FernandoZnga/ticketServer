<%-- 
    Document   : security
    Created on : Aug 28, 2018, 10:09:47 PM
    Author     : fernando
--%>

<%@page import="database.Dba"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    //seguridad de la pagina
    if (session.getAttribute("s_token") == null) {
        request.getRequestDispatcher("index.jsp?exist=3").forward(request, response);
    } else if (session.getAttribute("s_token") != null) {
        Dba db = new Dba("142.93.245.77:49161:XE");
        db.conectar();
        db.query.execute("SELECT valid "
                + "FROM usertoken "
                + "WHERE token ='" + session.getAttribute("s_token") + "' "
                + "AND valid = 1");
        ResultSet rs = db.query.getResultSet();
        while (rs.next()) {
            if (rs.getString(1).equals("1")) {
                break;
            } else {
                request.getRequestDispatcher("index.jsp?exist=3").forward(request, response);
            }
        }
    }
%>
