<%@page import="java.sql.*"%>
<%@include file="connexion.jsp"%>
<%@include file="menu.jsp"%>

<!<!doctype html>
<html>
    <head>
        <title>Ajouter un client | Plantes Urbaines</title>
    </head>
    <body>
        <form action="" method="POST">
            <fieldset>
                <legend>Ajouter un nouveau client</legend>
                <br>
                <input type="text" name="nom" id="nom" placeholder="nom">
                <br>
                <input type="text" name="prenom" id="prenom" placeholder="prénom">
                <br>
                <input type="tel" name="tel" id="tel" placeholder="téléphone">
                <br>
                <input type="mail" name="mail" id="mail" placeholder="email">
                <br>
                <input type="text" name="adresse" id="adresse" placeholder="adresse">
                <br>
                <input type="text" name="ville" id="ville" placeholder="ville">
                <br>
                <input type="text" name="cp" id="cp" placeholder="code postal">
                <br>
                <input type="submit" name="ajouter" value="Valider l'inscription">
            </fieldset>
        </form>
    </body>
</html>

<%
    if (request.getParameter ("ajouter") != null){
         String nom = request.getParameter("nom");
         String prenom = request.getParameter("prenom");
         String tel = request.getParameter("tel");
         String mail = request.getParameter("mail");
         String adresse = request.getParameter("adresse");
         String ville = request.getParameter("ville");
         String cp = request.getParameter("cp");
    
        try{
            Statement instruction = conn.createStatement();
            String sql = "INSERT INTO client (nom_cli, prenom_cli, tel_cli, email_cli, adr_cli, ville_cli, cp_cli, date_crea_cli) VALUES('"+nom+"','"+prenom+"','"+tel+"','"+mail+"','"+adresse+"','"+ville+"','"+cp+"',now());";
            instruction.executeUpdate(sql);
            instruction.close();
            out.println("Ajout effectué!");
        }catch(Exception ex){
            out.println("SQLException: "+ex.getMessage());
            out.println("SQLState: "+((SQLException)ex).getSQLState());
            out.println("VendorError: "+((SQLException)ex).getErrorCode());
        }
    }
%>
