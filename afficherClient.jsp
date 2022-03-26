<%@ page import="java.sql.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ include file = "connexion.jsp" %>


<!<!doctype html>
<html>
    <head>
        <meta http-equiv="Content-Type"/>
        <title>Afficher les clients | Plantes Urbaines</title>
    </head>
    <body>
        <%@ include file = "menu.jsp" %>
        <form action="" method="GET">
            <label> Trier par : </label>
            <select name="tri" id="tri">
                <option value="SELECT * FROM client ORDER BY id_client ASC">Afficher tous les clients</option>
                <option value="SELECT * FROM client ORDER BY date_crea_cli ASC">Trier par date d'inscription</option>
                <option value="SELECT * FROM client ORDER BY nom_cli ASC">Trier par ordre alphabétique</option>
            </select>
            <input type="submit" value="Ok">
            <% String test;
            if(request.getParameter("tri")==null){
            test = "SELECT * FROM client ORDER BY id_client ASC";
                }else{
                test = request.getParameter("tri");
                }
            out.println(" <table>"
                    + "<tr>"
                    + "<th>Nom</th>"
                    + "<th>Prénom</th>"
                    + "<th>Téléphone</th>"
                    + "<th>Mail</th>"
                    + "<th>Ville</th>"
                    + "<th>Code postal</th>"
                    + "<th>Client depuis le :</th>"
                    + "</tr>");
         try{
                Statement instruction = conn.createStatement();
                ResultSet resultat = instruction.executeQuery(test);
                SimpleDateFormat formater = new SimpleDateFormat("dd/MM/yyyy");
        
                while(resultat.next()){
                    out.println("<tr>");
                    out.println("<td>"+resultat.getString("nom_cli")+"</td>");
                    out.println("<td>"+resultat.getString("prenom_cli")+"</td>");
                    out.println("<td>"+resultat.getString("tel_cli")+"</td>");
                    out.println("<td>"+resultat.getString("email_cli")+"</td>");
                    out.println("<td>"+resultat.getString("ville_cli")+"</td>");
                    out.println("<td>"+resultat.getString("cp_cli")+"</td>");
                    java.util.Date date = resultat.getDate("date_crea_cli");
                    String dateCrea = formater.format(date);
                    out.println("<td>"+dateCrea+"</td>");
                    out.println("</tr>");
                    }
                    }catch(Exception ex){
                                  out.println("SQLException: "+ex.getMessage());
                                  out.println("SQLState: "+((SQLException) ex).getSQLState());
                                  out.println("VendorError: "+((SQLException) ex).getErrorCode());
                                  }%>
            </table>
        </form>
    </body>
</html>