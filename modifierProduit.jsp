<%@page import="java.sql.*" %>
<%@include file="connexion.jsp"%>

<!doctype html>
<html>
    <head>
        <title>Modifier produit | Plantes Urbaines</title>
    </head>
    <body>
        <%@include file="menu.jsp"%>
        <form action="" method="GET">
            <fieldset>
                <legend>Modifier un produit</legend>
                <select name="listeProduit" id="listeProduit">
                    <%
                        try{
                            Statement instruction = conn.createStatement();
                            ResultSet resultat = instruction.executeQuery("SELECT * FROM produits");
                            while(resultat.next()){
                                int idProduit = resultat.getInt("id_produit");
                                String libelle = resultat.getString("libelle_court_prod");
                                out.println("<option value='"+idProduit+"'>"+idProduit+" - "+libelle+"</option>");                       
                            }
                            out.println("</select>");
                            out.println("<input type='submit' name='valider' value='ok'>");
                        
                       
                            if(request.getParameter("valider")!=null){
                                String id = request.getParameter("listeProduit");
                                resultat = instruction.executeQuery("SELECT * FROM produits NATURAL JOIN prix WHERE id_produit = "+Integer.parseInt(id));
                               
                                resultat.next();
                                out.println("<table>");
                                out.println("<tr><th>Identifiant</th>");
                                out.println("<td><input type='text' name='idProduit' id='idProduit' value='"+resultat.getString("id_produit")+"'></td></tr>");
                                out.println("<tr><th>Libellé</th>");
                                out.println("<td><input type='text' name='libelle' id='libelle' value='"+resultat.getString("libelle_court_prod")+"'></td></tr>");
                                out.println("<tr><th>Description</th>");
                                out.println("<td> <textarea name='description' id='description' rows='5' cols='27'>"+resultat.getString("libelle_long_prod")+"</textarea></td></tr>");
                                out.println("<tr><th>Chemin de la photo</th>");
                                out.println("<td><input type='text' name='photo' id='photo' value='"+resultat.getString("chemin_photo_prod")+"'></td></tr>");
                                out.println("<tr><th>Quantité</th>");
                                out.println("<td><input type='text' name='quantite' id='quantite' value='"+resultat.getString("quantite_prod")+"'></td></tr>");
                                out.println("<tr><th>Prix unitaire</th>");
                                out.println("<td><input type='text' name='prix' id='prix' value='"+resultat.getString("prix_prix")+"'></td></tr>");
                                out.println("<tr><th>Début de la promotion </th>");
                                out.println("<td><input type='date' name='dateDebut' id='dateDebut' value='"+resultat.getDate("date_debutVal_prix")+"'></td></tr>");
                                out.println("<tr><th>Fin de Promotion:</th>");
                                out.println("<td><input type='date' name='dateFin' id='dateFin' value='"+resultat.getDate("date_finVal_prix")+"'></td></tr>");
                                
                                out.println("<tr><td><input type='submit' name='modifier' value='Modifier'></td></tr>");
                            } 
                        }catch(Exception ex){
                            out.println("SQLException: "+ex.getMessage());
                            out.println("SQLState: "+((SQLException) ex).getSQLState());
                            out.println("VendorError: "+((SQLException) ex).getErrorCode());
                        }
                    %>
                    </table>
            </fieldset>
        </form>
    </body>
</html>
<%
        
        
            if(request.getParameter("modifier")!=null){
            
                int id = Integer.parseInt(request.getParameter("idProduit"));
                String libelle = request.getParameter("libelle");
                String description = request.getParameter("description");
                String photo = request.getParameter("photo");
                int quantite = Integer.parseInt(request.getParameter("quantite"));
                double prix = Double.parseDouble(request.getParameter("prix"));
                String dateDebut = request.getParameter("dateDebut");
                String dateFin = request.getParameter("dateFin");
                try{
                    conn=DriverManager.getConnection(url, login, password);
                    PreparedStatement prep = null;
                
                    prep = conn.prepareStatement("UPDATE produits  NATURAL JOIN  prix  SET libelle_court_prod=?, libelle_long_prod=?, chemin_photo_prod=?, quantite_prod=?, prix_prix=?, date_debutVal_prix=?, date_finVal_prix=? WHERE id_produit=?;");
                
                    prep.setString(1,libelle);
                    prep.setString(2,description);
                    prep.setString(3,photo);
                    prep.setInt(4,quantite);
                    prep.setDouble(5,prix);
                    prep.setString(6,dateDebut);
                    prep.setString(7,dateFin);
                    prep.setInt(8,id);
                    prep.executeUpdate();
                
                    prep.close();
                
                    out.println("Modification effectuée");
                }catch(Exception ex){
                    out.println("SQLException: "+ex.getMessage());
                    out.println("SQLState: "+((SQLException) ex).getSQLState());
                    out.println("VendorError: "+((SQLException) ex).getErrorCode());
                }
            }
%>