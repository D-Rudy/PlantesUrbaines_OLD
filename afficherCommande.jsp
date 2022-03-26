<%@page import="java.sql.*" %>
<%@include file="connexion.jsp" %>
<%@include file="menu.jsp" %>

<!<!doctype html>
<html>
    <head>
        <title>Commandes | Plantes Urbaines</title>
    </head>
    <body>
        <form action ="" method="GET">
            <label>Trier par:</label>
            <select name="tri" id="tri">
                <option value="SELECT nom_cli, prenom_cli, libelle_court_prod,date_comm FROM client NATURAL JOIN commande NATURAL JOIN detail_commande NATURAL JOIN produits">Afficher toutes les commandes</option>
                <option value="SELECT nom_cli, prenom_cli, libelle_court_prod,date_comm FROM client NATURAL JOIN commande NATURAL JOIN detail_commande NATURAL JOIN produits ORDER BY libelle_court_prod">Produits</option>
                <option value="SELECT nom_cli, prenom_cli, libelle_court_prod,date_comm FROM client NATURAL JOIN commande NATURAL JOIN detail_commande NATURAL JOIN produits ORDER BY date_comm">Date</option>
            </select>
            <input type="submit" value="ok">
            <%
                String sql;
                if(request.getParameter("tri")==null){
                sql = "SELECT nom_cli, prenom_cli, libelle_court_prod,date_comm FROM client NATURAL JOIN commande NATURAL JOIN detail_commande NATURAL JOIN produits";
                request.getParameter(sql);
                }else{
               sql = request.getParameter("tri");
                }
                out.println("<table>"
                        + "<tr>"
                        +"<th>Nom</th>"
                        +"<th>Prénom</th>"
                        +"<th>Produit</th>"
                        +"<th>Date de commande</th>");
                try{
                Statement instruction = conn.createStatement();
                ResultSet resultat = instruction.executeQuery(sql);
                SimpleDateFormat formater = new SimpleDateFormat("dd/MM/yyyy");
                
                while(resultat.next()){
                out.println("<tr><td>"+resultat.getString("nom_cli")+"</td>");
                out.println("<td>"+resultat.getString("prenom_cli")+"</td>");
                out.println("<td>"+resultat.getString("libelle_court_prod")+"</td>");
                java.util.Date date = resultat.getDate("date_comm");
                String dateComm = formater.format(date);
                out.println("<td>"+dateComm+"</td></tr>");
                
                }
                }catch(Exception ex){
                          out.println("SQLException: "+ex.getMessage());
                          out.println("SQLState: "+((SQLException) ex).getSQLState());
                          out.println("VendorError: "+((SQLException) ex).getErrorCode());
                          }
            %>
        </form>
    </body>
</html>