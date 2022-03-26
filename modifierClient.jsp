<%@page import="java.sql.*" %>
<%@include file="connexion.jsp"%>
<!doctype html>
<html>
    <head>
        <title>Modifier client | Plantes Urbaines</title>
    </head>
    <body>
        <%@include file="menu.jsp" %>
        <form action="" method="GET">
            <fieldset>
                <legend>Modifier un client</legend>
                <select name="listeClient" id="listeClient">
                    <%  try{
                            Statement instruction = conn.createStatement();
                            ResultSet resultat = instruction.executeQuery("SELECT * FROM client");
                            while(resultat.next()){
                                int id__ = resultat.getInt("id_client");
                                out.println("<option value=\""+id__+"\">"+id__+"-"+resultat.getString("nom_cli")+""+resultat.getString("prenom_cli")+"</option>");
                            }
                            out.println("</select>");
                        }catch(Exception ex){
                            out.println("SQLException: "+ex.getMessage());
                            out.println("SQLState: "+((SQLException) ex).getSQLState());
                            out.println("VendorError: "+((SQLException) ex).getErrorCode());
                        }
                    %>
                    <input type="submit" name="OK" value="OK">
                    <%
                        try{
                            String id = request.getParameter("listeClient");
                    
                            if(request.getParameter("OK") != null){
                                Statement instruction = conn.createStatement();
                                ResultSet resultat = instruction.executeQuery("SELECT * FROM client WHERE id_client = "+Integer.parseInt(id));
                    
                                resultat.next();
                                out.println("<table>");
                                out.println("<tr><th>Identifant</th><td>");
                                out.println("<input type='text' name='id_client'id='id_client' value='"+resultat.getString("id_client")+"'>");
                                out.println("<tr><th>Nom</th><td>");
                                out.println("<input type='text' name='nom'id='nom' value='"+resultat.getString("nom_cli")+"'>");
                                out.println("</td></tr><tr><th>Prénom</th><td>");
                                out.println("<input type='text' name='prenom' id='prenom' value='"+resultat.getString("prenom_cli")+"'>");
                                out.println("</td></tr><tr><th>Télephone</th><td>");
                                out.println("<input type='tel' name ='tel' id='tel' value ='"+resultat.getString("tel_cli")+"'>");
                                out.println("</td></tr><tr><th>Mail</th><td>");
                                out.println("<input type ='mail' name ='mail' id='mail' value='"+resultat.getString("email_cli")+"'");
                                out.println("</td></tr><tr><th>Adresse</th><td>");
                                out.println("<input type ='text' name ='adresse' id='adresse' value='"+resultat.getString("adr_cli")+"'");
                                out.println("</td></tr><tr><th>Ville</th><td>");
                                out.println("<input type ='text' name ='ville' id='ville' value='"+resultat.getString("ville_cli")+"'");
                                out.println("</td></tr><tr><th>Code Postal</th><td>");
                                out.println("<input type ='text' name ='cp' id='cp' value='"+resultat.getString("cp_cli")+"'");
                                out.println("</td></tr");
                            
                             }else{
                                Statement instruction = conn.createStatement();
                                ResultSet resultat = instruction.executeQuery("SELECT * FROM client WHERE id_client =1 ");
                    
                                resultat.next();
                                out.println("<table>");
                                out.println("<tr><th>Identifant</th><td>");
                                out.println("<input type='text' name='id_client'id='id_client' value='"+resultat.getString("id_client")+"'>");
                                out.println("<tr><th>Nom</th><td>");
                                out.println("<input type='text' name='nom'id='nom' value='"+resultat.getString("nom_cli")+"'>");
                                out.println("</td></tr><tr><th>Prénom</th><td>");
                                out.println("<input type='text' name='prenom' id='prenom' value='"+resultat.getString("prenom_cli")+"'>");
                                out.println("</td></tr><tr><th>Télephone</th><td>");
                                out.println("<input type='tel' name ='tel' id='tel' value ='"+resultat.getString("tel_cli")+"'>");
                                out.println("</td></tr><tr><th>Mail</th><td>");
                                out.println("<input type ='mail' name ='mail' id='mail' value='"+resultat.getString("email_cli")+"'");
                                out.println("</td></tr><tr><th>Adresse</th><td>");
                                out.println("<input type ='text' name ='adresse' id='adresse' value='"+resultat.getString("adr_cli")+"'");
                                out.println("</td></tr><tr><th>Ville</th><td>");
                                out.println("<input type ='text' name ='ville' id='ville' value='"+resultat.getString("ville_cli")+"'");
                                out.println("</td></tr><tr><th>Code Postal</th><td>");
                                out.println("<input type ='text' name ='cp' id='cp' value='"+resultat.getString("cp_cli")+"'");
                                out.println("</td></tr");
                            
                             }
                        
                    
                        }catch(Exception ex){
                             out.println("SQLException: "+ex.getMessage());
                             out.println("SQLState: "+((SQLException) ex).getSQLState());
                             out.println("VendorError: "+((SQLException) ex).getErrorCode());
                          }
                    %>
                    <tr>
                        <td><input type="submit" name="modifier" value="modifier"></td>
                    </tr>
                    </table>
            </fieldset>
        </form>
    </body>
</html>
<%
        if(request.getParameter("modifier")!=null){
            int id_client = Integer.parseInt(request.getParameter("id_client"));
            String nom = request.getParameter("nom");
            String prenom = request.getParameter("prenom");
            String tel = request.getParameter("tel");
            String mail = request.getParameter("mail");
            String adresse = request.getParameter("adresse");
            String ville = request.getParameter("ville");
            String cp = request.getParameter("cp");
            try{
                conn=DriverManager.getConnection(url, login, password);
                PreparedStatement prep = null;
                prep = conn.prepareStatement("UPDATE client SET nom_cli=?, prenom_cli=?, tel_cli=?, email_cli=?, adr_cli=?, ville_cli=?, cp_cli=? WHERE id_client=?");
         
                prep.setString(1, nom);
                prep.setString(2, prenom);
                prep.setString(3, tel);
                prep.setString(4, mail);
                prep.setString(5, adresse);
                prep.setString(6, ville);
                prep.setString(7, cp);
                prep.setInt(8, id_client);
         
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