<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*,java.text.*" errorPage="" %>

<%@ page import="java.util.Date"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ include file = "connexion.jsp" %>
<%DateFormat Date = DateFormat.getDateInstance();
    Calendar cals = Calendar.getInstance();
    String date = Date.format(cals.getTime());
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type"/>
        <link rel="stylesheet" type="text/css" href="css/styleAccueil.css" />
        <title>Plant Urbaines | Accueil</title>
    </head>
    <body>
        <%@ include file ="menu.jsp" %>
        <img id="logo" src="image/logo.png" alt="logo Magasin de plantes vertes"/>
        <h1>  Plantes Urbaines</h1>
        <h4>On va vous faire aimer les plantes !</h4>
        <img id="logo" src="image/accueil.jpg" alt="Magasin de plantes vertes"/>
        <h2>Nous somme le <%= date %></h2>
    </body>
</html>