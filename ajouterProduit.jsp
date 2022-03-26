<%@page import="java.sql.*" %>
<%@include file="connexion.jsp"%>
<!<!doctype html>
<html>
    <head>
        <title>Ajouter un produit | Plantes Urbaines</title>
    </head>
    <body>
        <%@include file="menu.jsp"%>
        <form action=""method="GET">
            <fieldset>
                <legend>Ajouter un produit</legend>
                <br>
                <input type="text" name="libelle" id="libelle" placeholder="libellé">
                <br>
                <textarea name="description" id="description" placeholder="description" rows="5" cols="27"></textarea>
                <br>
                <input type="text" name="photo" id="photo" placeholder="chemin vers la photo">
                <br>
                <input type="text" name="quantite" id="quantite" placeholder="quantité">
                <br>
                <input type="text" name="prix" id="prix" placeholder="prix unitaire">
                <br>
                <input type="submit" name="ajouter" value="Ajouter">
                <br>  
            </fieldset>
        </form>
    </body>
</html>
<%
    if(request.getParameter("ajouter") !=null){
        String libelle = request.getParameter("libelle");
        String description = request.getParameter("description");
        String photo = request.getParameter("photo");
        int quantite = Integer.parseInt(request.getParameter("quantite"));
        double prix = Double.parseDouble(request.getParameter("prix"));
    
         String sql = "INSERT INTO produits (libelle_court_prod, libelle_long_prod,chemin_photo_prod, quantite_prod, date_creat_prod) VALUES ('"+libelle+"','"+description+"','"+photo+"','"+quantite+"',now());";
    
        try{
            Statement instruction = conn.createStatement();
            instruction.executeUpdate(sql);
    
            //Recuperer id_produit pour insérer le prix dans la table prix: 
            ResultSet idProduit = instruction.executeQuery("SELECT MAX(id_produit) AS idMax from produits;");
            int idProd = 0;
            if(idProduit.next()){
                idProd = idProduit.getInt("idMax");
                }else{
                out.println("Erreur lors de la création");
            }
            sql = "INSERT INTO prix(date_debutVal_prix,prix_prix, id_produit)VALUES(now(),"+prix+","+idProd+");";
            instruction.executeUpdate(sql);
    
             instruction.close();
            out.println("Bien ajouté");
        }catch(Exception ex){
            out.println("SQLException: "+ex.getMessage());
            out.println("SQLState: "+((SQLException)ex).getSQLState());
            out.println("VendorError: "+((SQLException)ex).getErrorCode());
        }
    }
%>