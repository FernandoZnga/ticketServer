<%-- 
    Document   : newComment
    Created on : Aug 30, 2018, 11:19:43 PM
    Author     : fernando
--%>

<%@page import="database.Dba"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Agregar Tickets</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    </head>
    <body onload>
        <div class="container">
            <div class="row">
                <div class="col-md-8 col-md-offset-2">
                    <form role="form" method="POST" action="newComment.jsp">
                        <legend class="text-center">Agregar Comentario</legend>
                        <fieldset>
                            <div class="form-group">
                                <label for="comment">Agregue un Comentario</label>
                                <textarea class="form-control" rows="5" id="comment" name="comment" required ></textarea>
                            </div>
                        </fieldset>
                        <div class="form-group">
                            <div class="col-md-10">
                                <input onclick="addComment();" type="submit" value="Agregar" name="btAgregarComment" id="btAgregarComment" class="btn btn-primary"/>
                                <a href="javascript:cerrar();"> Cancelar</a>
                                <input type="text" name="ticket" value="<%=request.getParameter("ticket")%>" hidden=>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <script language="javascript" type="text/javascript">
            function cerrar() {
                if (confirm("Seguro quiere salir?")) {
                    close();
                }
            }
        </script>

        <%
            if (request.getParameter("btAgregarComment") != null) {

                try {
                    Dba db = new Dba("142.93.245.77:49161:XE");
                    db.conectar();
                    String qry = "CALL pr_insert_newcomment('"
                            + request.getParameter("comment") + "','"
                            + session.getAttribute("s_username") + "','"
                            + request.getParameter("ticket") + "')";
                    out.print(qry);
                    db.query.execute(qry);
                    db.desconectar();
        %>
        <script>
            window.close();
        </script>
        <%
                } catch (Exception e) {
                    e.printStackTrace();
                    out.print(e);
                    request.getRequestDispatcher("main.jsp?exist=200").forward(request, response);
                }
            }
        %>


    </body>
</html>
