<%@ page import="java.sql.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ include file="connexion.jsp"%>
<%@ include file="menu.jsp"%>

<!Doctype html>
<head>

    <title>Afficher le stock | Plantes Urbaines</title>
</head>
<body>
    <<form action="" method="GET">
        <label> Trier par : </label>
        <select name="tri" id="tri">
            <option value="SELECT * FROM produits NATURAL JOIN prix ORDER BY id_produit">Afficher tous les produits</option>
            <option value="SELECT * FROM produits NATURAL JOIN prix ORDER BY date_derniere_commande ASC">Date de commande</option>
            <option value="SELECT * FROM produits NATURAL JOIN prix ORDER BY quantite_prod ASC">Quantité</option>
            <option value="SELECT * FROM produits NATURAL JOIN prix ORDER BY prix_prix ASC">Prix croissant</option>
            <option value="SELECT * FROM produits NATURAL JOIN prix ORDER BY prix_prix DESC">Prix décroissant</option>
        </select>
        <input type="submit" value="Ok">

        <% 
            String sql;
            if(request.getParameter("tri") == null){
            sql = "SELECT * FROM produits NATURAL JOIN prix ORDER BY id_produit";
            }else{
            sql = request.getParameter("tri");
            }
             out.println("<table>"
                + "<tr>"
                + "<th></th>"
                + "<th>Produit</th>"
                + "<th>Description</th>"
                + "<th>Quantité</th>"
                + "<th>Prix</th>"
                + "<th>Date de la dernière commande</th>"
                + "</tr>");
     try{
            Statement instruction = conn.createStatement();
            ResultSet resultat = instruction.executeQuery(sql);
            SimpleDateFormat formater = new SimpleDateFormat("dd/MM/yyyy");
        
            while(resultat.next()){
                String image = resultat.getString("chemin_photo_prod");
                out.println("<tr>");
                out.println("<td><img src = '"+image+"' style = 'width: 150px'; 'height: 150 px'></td>");
                out.println("<td>"+resultat.getString("libelle_court_prod")+"</td>");
                out.println("<td>"+resultat.getString("libelle_long_prod")+"</td>");
                out.println("<td>"+resultat.getInt("quantite_prod")+"</td>");
                out.println("<td>"+resultat.getString("prix_prix")+"</td>");
                java.util.Date date = resultat.getDate("date_derniere_commande");
                if (date !=null){
                String dateCommande = formater.format(date);
                out.println("<td>"+dateCommande+"</td>");
                out.println("</tr>");
                }else{
                String dateCommande ="Aucune";
                out.println("<td>"+dateCommande+"</td>");
                out.println("</tr>");
            }
                }
                }catch(Exception ex){
                              out.println("SQLException: "+ex.getMessage());
                              out.println("SQLState: "+((SQLException) ex).getSQLState());
                              out.println("VendorError: "+((SQLException) ex).getErrorCode());
                              }
        %>

        </table>
    </form>
</body>