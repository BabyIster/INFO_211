<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@page import="eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocator,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceEntreprise,
                eu.telecom_bretagne.cabinet_recrutement.data.model.Entreprise"%>

<%
  Object utilisateur = session.getAttribute("utilisateur");
%>

<div class="navbar-header">

  <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
    <span class="sr-only">Toggle navigation</span>
    <span class="icon-bar"></span>
    <span class="icon-bar"></span>
    <span class="icon-bar"></span>
  </button>
  <h4><a class="navbar-brand" href="template.jsp">Cabinet de recrutement</a></h4><br/>

</div> <!-- /.navbar-header -->

  <ul class="nav navbar-top-links">

  <!-- Menu des messages -->
  
  <!-- Menu connexion -->
  <%
  if (utilisateur == null){
  %>
    <li><a href="#"><i class="fa fa-user fa-fw"></i> Aucun utilisateur connecté</a></li>
    <li class="divider"></li>
    <li><a href="template.jsp?action=connexion"><i class="fa fa-sign-in fa-fw"></i> Login</a></li>
  <%
  }
  else{%>
	<li><a href="#"><i class="fa fa-user fa-fw"></i>Utilisateur : <%=utilisateur %></a></li>
	<%  
  }
  %>
    </ul>
  
  
  