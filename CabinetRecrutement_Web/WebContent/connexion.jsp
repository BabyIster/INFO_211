<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@page import="eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocator,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceEntreprise,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceCandidature,
                eu.telecom_bretagne.cabinet_recrutement.data.model.Entreprise,
                eu.telecom_bretagne.cabinet_recrutement.data.model.Candidature"%>

<%
  IServiceEntreprise serviceEntreprise = (IServiceEntreprise) ServicesLocator.getInstance().getRemoteInterface("ServiceEntreprise");
  IServiceCandidature serviceCandidature = (IServiceCandidature) ServicesLocator.getInstance().getRemoteInterface("ServiceCandidature");
  
  String identifiantUser = request.getParameter("identifiantUser");
  Object identifiantSession = session.getAttribute("utilisateur");
  
  String erreur = null;
%>
<!DOCTYPE html>
<html lang="en">
  <jsp:include page="fragments/head.html" />
  <body>
    <div id="wrapper">
      <!-- Navigation -->
      <nav class="navbar
                  navbar-default
                  navbar-static-top"
           role="navigation"
           style="margin-bottom: 0">
        <jsp:include page="fragments/bandeau.jsp" />
        <jsp:include page="fragments/menu.jsp" />
      </nav>
      <div id="page-wrapper">
        <p style="font-size: 5">&nbsp;</p>

<div class="row">
  <div class="col-lg-12">
    <div class="panel panel-default">
      <div class="panel-heading"><h3><i class="fa fa-th"></i> Info connexion </h3></div> <!-- /.panel-heading -->
      <div class="panel-body">   
<%

if(identifiantUser == null && identifiantSession == null){%>

        <div class="dataTable_wrapper">
        
		  <form action="connexion.jsp" method="post">
		  <div class="form-group">
		    <label for="identifiantUser">Votre identifiant :</label>
		    <input type="text" class="form-control" name="identifiantUser" placeholder="Identifiant">
		  </div>
		  <button type="submit" class="btn btn-lg btn-success btn-block">Se connecter</button>
		</form>
		<br><br>
		<div class="alert alert-info col-xs-offset-3 col-xs-6">
                         L'identifiant est la clé primaire préfixée de :
                         <ul>
                           <li>pour une entreprise : <code>ENT_</code> <em>(ENT_12 par exemple)</em></li>
                           <li>pour une candidature : <code>CAND_</code> <em>(CAND_7 par exemple)</em></li>
                         </ul>
                         <br>
                         <em>Note : l'identification se fait sans mot de passe.</em>
                       </div>
        </div> <!-- /.table-responsive -->

<%}
else{
	if(identifiantUser.equals("")){
		erreur="Vous avez entrer un identifiant vide !";
		}
	else if(identifiantSession != null){
	%>
	        <div class="dataTable_wrapper">
			<br><br>
			<div class="alert alert-info col-xs-offset-3 col-xs-6">
	                         Vous êtes déjà connecté        
	                         <ul>
	                           <li>Si vous voulez vous deconnectez : <a href="template.jsp?action=deconnexion">login out</a></li>
	                         </ul>
	                         <br>
	                         <em>Note : l'identification se fait sans mot de passe.</em>
	                       </div>
	        </div> <!-- /.table-responsive -->
	<%
	}
	else if(identifiantUser.startsWith("ENT_")){
		
  		int idEnt = Integer.parseInt(identifiantUser.substring(4)); // On enlève le préfixe "ENT_";
  		Entreprise entreprise = serviceEntreprise.getEntreprise(idEnt);
  		if(entreprise == null)
  		{
  			erreur = "Il n y a pas d entreprise avec cet identifiant : ENT_"+identifiantUser;
  		}
  		else
  		{
        session.setAttribute("utilisateur",entreprise);
        response.sendRedirect("template.jsp");
  		}
	}
	else if(identifiantUser.startsWith("CAND_"))
  	{
  		int id = Integer.parseInt(identifiantUser.substring(5)); // On enlève le préfixe "CAND_";
  		Candidature candidature = serviceCandidature.getCandidature(id);
      if(candidature == null)
      {
        erreur = "Il n y a pas de candidat avec cet identifiant : CAND_"+identifiantUser;
      }
      else
      {
        session.setAttribute("utilisateur",candidature);
        response.sendRedirect("template.jsp");
      }
  	}
	else{
		erreur = "votre identifiant est mal écrit";
	}
}
if(erreur != null) // Une erreur a été détectée et est affichée.
      {
       %>
       <div class="dataTable_wrapper">
        
		  <form action="connexion.jsp" method="post">
		  <div class="form-group">
		    <label for="identifiantUser">Votre identifiant :</label>
		    <input type="text" class="form-control" name="identifiantUser" placeholder="Identifiant">
		  </div>
		  <button type="submit" class="btn btn-lg btn-success btn-block">Se connecter</button>
		</form>
		<br><br>
		<div class="row col-xs-offset-1 col-xs-10">
         <div class="panel panel-red">
           <div class="panel-heading ">
             Impossible de traiter la demande
           </div>
           <div class="panel-body text-center">
             <p class="text-danger"><strong><%=erreur%></strong></p>
           </div>
         </div>
       </div> <!-- /.row col-xs-offset-1 col-xs-10 -->
		<div class="alert alert-info col-xs-offset-3 col-xs-6">
                         L'identifiant est la clé primaire préfixée de :
                         <ul>
                           <li>pour une entreprise : <code>ENT_</code> <em>(ENT_12 par exemple)</em></li>
                           <li>pour une candidature : <code>CAND_</code> <em>(CAND_7 par exemple)</em></li>
                         </ul>
                         <br>
                         <em>Note : l'identification se fait sans mot de passe.</em>
                       </div>
        </div> <!-- /.table-responsive -->
       <%
       }%>

			      </div> <!-- /.panel-body -->
			    </div> <!-- /.panel -->
			  </div> <!-- /.col-lg-12 -->
			</div> <!-- /.row -->
		</div> <!-- /#page-wrapper -->
    </div> <!-- /#wrapper -->
    <jsp:include page="fragments/fin_de_page.html" />
  </body>
</html>