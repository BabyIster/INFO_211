<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@page import="eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocator,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceEntreprise,
                eu.telecom_bretagne.cabinet_recrutement.data.model.Entreprise,
                eu.telecom_bretagne.cabinet_recrutement.data.model.Candidature"%>
                
<%
Object utilisateur = session.getAttribute("utilisateur");
Entreprise entreprise = null;
Candidature candidature = null;
String user = null;

if(utilisateur instanceof Entreprise)
	{
		entreprise = (Entreprise) utilisateur;
		user = "entreprise";
	}
else if(utilisateur instanceof Candidature)
	{
		candidature = (Candidature) utilisateur;
		user = "candidature";
	}
%>

<div class="navbar-default sidebar" role="navigation">
  <div class="sidebar-nav navbar-collapse">
  
    <ul class="nav" id="side-menu">

      <!--
        MENU PRINCIPAL
      -->

      <li><a href="index.jsp"><i class="fa fa-home"></i> Accueil</a></li>
      <li>
        <a href="#"><i class="fa fa-th"></i> Gestion des entreprises<span class="fa arrow"></span></a>
        <ul class="nav nav-second-level">
          <li><a href="template.jsp?action=add_entreprise">Nouvelle entreprise</a></li>
          <li><a href="template.jsp?action=liste_entreprises">Liste des entreprises</a></li>
          <li><a href="template.jsp?action=liste_offres">Liste de toutes les offres d'emploi</a></li>
        </ul> <!-- /.nav-second-level -->
      </li>
      <li>
        <a href="#"><i class="fa fa-users"></i> Gestion des candidatures<span class="fa arrow"></span></a>
        <ul class="nav nav-second-level">
          <li><a href="template.jsp?action=add_candidature">Nouvelle candidature</a></li>
          <li><a href="template.jsp?action=liste_candidatures">Liste des candidatures</a></li>
        </ul> <!-- /.nav-second-level -->
      </li>

<!--
        MENU ENTREPRISE
      -->
      <%
      if(user == "entreprise"){
    	  %>
	  <li><h4>&nbsp;</h4></li>
      <li>
        <a href="#"><i class="fa fa-th"></i> Menu <b>ENTREPRISE</b><span class="fa arrow"></span></a>
        <ul class="nav nav-second-level">
          <li><a href="template.jsp?action=update_entreprise">Mettre � jour les informations de l'entreprise</a></li>
          <li><a href="template.jsp?action=add_offre">Poster une nouvelle offre</a></li>
          <li><a href="template.jsp?action=offres_entreprise">Vos offres publi�es</a></li>
        </ul> <!-- /.nav-second-level -->
      </li>
<%}%>

<!--
        MENU CANDIDAT
      -->
      <%
      if(user == "candidature"){
    	  %>
	  <li><h4>&nbsp;</h4></li>
      <li>
        <a href="#"><i class="fa fa-th"></i> Menu <b>CANDIDAT</b><span class="fa arrow"></span></a>
        <ul class="nav nav-second-level">
          <li><a href="template.jsp?action=update_candidature">Mettre � jour sa candidature</a></li>
          <li><a href="template.jsp?action=liste_offres_candidat">Offres potentielles</a></li>
        </ul> <!-- /.nav-second-level -->
      </li>
<%}%>

      <!--
        MENU SECONDAIRE
      -->

      <li><h4>&nbsp;</h4></li>
      <li><a href="http://formations.telecom-bretagne.eu/fip_inf210_fil_rouge/" target="_blank"><i class="fa fa-question-circle"></i> Documentation du fil rouge</a></li>
      <li><a href="http://srv-labs-006.enst-bretagne.fr/CabinetRecrutement_Web/" target="_blank"><i class="fa fa-certificate"></i> D�monstration du prototype</a></li>
      <li><a href="bootstrap/pages/" target="_blank"><i class="fa fa-thumbs-up"></i> D�mo du template SB Admin 2</a></li>
    </ul>
  </div> <!-- /.sidebar-collapse -->
</div> <!-- /.navbar-static-side -->
