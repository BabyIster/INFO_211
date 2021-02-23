<%@ page language="java" contentType="text/html" pageEncoding="ISO-8859-1"%>

<%@page import="eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocator,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceEntreprise,
                eu.telecom_bretagne.cabinet_recrutement.data.model.Entreprise,
                eu.telecom_bretagne.cabinet_recrutement.front.utils.Utils,
                java.util.List"%>

<%
IServiceEntreprise serviceEntreprise = (IServiceEntreprise) ServicesLocator.getInstance().getRemoteInterface("ServiceEntreprise");

Object utilisateur = session.getAttribute("utilisateur");
String erreur = null;

String nom = request.getParameter("InputNomEntreprise");
String desc = request.getParameter("InputDescEntreprise");
String ville = request.getParameter("InputVilleEntreprise");

%>
<div class="row">
		  <div class="col-lg-12">
		    <div class="panel panel-default">
		      <div class="panel-heading"><h3><i class="fa fa-th"></i> Mettre à jour les informations de l'entreprise</h3></div> <!-- /.panel-heading -->
		      <div class="panel-body">
		        <div class="dataTable_wrapper">
<%

if(utilisateur instanceof Entreprise)
{
	Entreprise entreprise = (Entreprise) utilisateur;
	
	/*if(ville != null & ville.matches("[A-Za-z0-9]+")){
		  erreur = "On ne met pas de chiffre dans le nom d'une ville !";
	}*/
	if(nom != null & desc != null & ville != null){
		  
		  entreprise.setAdressePostale(ville);
		  entreprise.setDescriptif(desc);
		  entreprise.setNom(nom);
		  entreprise = serviceEntreprise.UpdateEntreprise(entreprise);
		  
		  %>
	        <div class="table-responsive">
	            <small>
	            <table class="table">
	              <tbody>
	                <tr class="success">
	                  <td width="200"><strong>Identifiant (login)</strong></td>
	                  <td>ENT_<%=entreprise.getId()%></td>
	                </tr>
	                <tr class="warning">
	                  <td><strong>Nom</strong></td>
	                  <td><%=entreprise.getNom()%></td>
	                </tr>
	                <tr class="warning">
	                  <td><strong>Adresse postale (ville)</strong></td>
	                  <td><%=entreprise.getAdressePostale()%></td>
	                </tr>
	                <tr class="warning">
	                  <td><strong>Descriptif</strong></td>
	                  <td><%=Utils.text2HTML(entreprise.getDescriptif())%></td>
	                </tr>
	              </tbody>
	            </table>
	            </small>
	            <br><b><a href="template.jsp">Retour a l'accueil</a></b>      
	        </div>
	          <%
	}
	else{
		%>  
				  <form action="template.jsp?action=update_entreprise" method="post">
				  <div class="form-group">
				    <input type="text" class="form-control" aria-describedby="emailHelp" value="ENT_<%=entreprise.getId() %>" disabled="disabled">
				  </div>
				  <div class="form-group">
				    <label for="InputNomEntreprise">Nom</label>
				    <input class="form-control" value="<%=entreprise.getNom() %>" name="InputNomEntreprise">
				  </div>
				  <div class="form-group">
				    <label for="InputDescEntreprise">Description</label>
				    <textarea type="text" class="form-control" name="InputDescEntreprise" rows="5"><%=entreprise.getDescriptif() %>"</textarea>
				  </div>
				  <div class="form-group">
				    <label for="InputVilleEntreprise">Ville</label>
				    <input type="text" class="form-control" name="InputVilleEntreprise" value="<%=entreprise.getAdressePostale() %>">
				  </div>
				 
				  <button type="submit" class="btn btn-primary">Valider</button>
				</form>
		<%
	}
}
else
{
	erreur = "Vous n'êtes pas autorisé à accéder à cette page";
	%>
    <div class="row col-xs-offset-1 col-xs-10">
      <div class="panel panel-red">
        <div class="panel-heading ">
          Impossible de traiter la demande
        </div>
        <div class="panel-body text-center">
          <p class="text-danger"><strong><%=erreur%></strong></p>
        </div>
      </div>
      <br><b><a href="template.jsp">Retour a l'accueil</a></b>
    </div> <!-- /.row col-xs-offset-1 col-xs-10 -->
    <%
}

%>
		        </div> <!-- /.table-responsive -->
		      </div> <!-- /.panel-body -->
		    </div> <!-- /.panel -->
		  </div> <!-- /.col-lg-12 -->
		</div> <!-- /.row -->
