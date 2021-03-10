<%@page import="eu.telecom_bretagne.cabinet_recrutement.service.IServiceCandidature"%>
<%@page import="eu.telecom_bretagne.cabinet_recrutement.data.model.Candidature"%>
<%@ page language="java" contentType="text/html" pageEncoding="ISO-8859-1"%>

<%@page import="eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocator,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceEntreprise,
                eu.telecom_bretagne.cabinet_recrutement.data.model.Entreprise,
                eu.telecom_bretagne.cabinet_recrutement.front.utils.Utils,
                java.util.List,
                java.text.SimpleDateFormat,
                java.util.Date"%>

<%
IServiceCandidature serviceCandidature = (IServiceCandidature) ServicesLocator.getInstance().getRemoteInterface("ServiceCandidature");

SimpleDateFormat formater2 = new SimpleDateFormat("yyyy-MM-dd");
SimpleDateFormat formater = new SimpleDateFormat("dd/MM/yy");

Object utilisateur = session.getAttribute("utilisateur");
String erreur = null;

String nom = request.getParameter("InputNomCand");
String prenom = request.getParameter("InputPrenomCand");
String cv = request.getParameter("InputCV");
String ville = request.getParameter("InputVilleCand");
String naissance = request.getParameter("InputDateNaissance");
String mail = request.getParameter("InputMailCand");

%>
<div class="row">
		  <div class="col-lg-12">
		    <div class="panel panel-default">
		      <div class="panel-heading"><h3><i class="fa fa-th"></i> Mettre à jour les informations de votre candidature</h3></div> <!-- /.panel-heading -->
		      <div class="panel-body">
		        <div class="dataTable_wrapper">
<%

if(utilisateur instanceof Candidature)
{
	Candidature candidature = (Candidature) utilisateur;
	
	if(nom==null & cv==null & ville==null & prenom==null & naissance==null & mail==null){
		%>  
		  <form action="template.jsp?action=update_candidature" method="post">
		  <div class="form-group">
		    <input type="text" class="form-control" aria-describedby="emailHelp" value="CAND_<%=candidature.getId() %>" disabled="disabled">
		  </div>
		  <div class="form-group">
		    <label for="InputNomCand">Nom</label>
		    <input class="form-control" value="<%=candidature.getNom() %>" name="InputNomCand">
		  </div>
		  <div class="form-group">
		    <label for="InputPrenomCand">Prénom</label>
		    <input class="form-control" name="InputPrenomCand" value="<%=candidature.getPrenom()%>">
		  </div>
		  <div class="form-group">
		    <label for="InputVilleCand">Ville</label>
		    <input type="text" class="form-control" name="InputVilleCand" value="<%=candidature.getAdressePostale() %>">
		  </div>
		   <div class="form-group">
		    <label for="InputCV">CV</label>
		    <textarea type="text" class="form-control" name="InputCV" row="5"><%=candidature.getCv() %></textarea>
		  </div>
		  <div class="form-group">
		    <label for="InputDateNaissance">Date de naissance</label>
		    <input type="date" class="form-control" name="InputDateNaissance" placeholder="Date de naissance" value="<%=formater2.format(candidature.getDateNaissance()) %>" required>
		  </div>
		   </div>
		   <div class="form-group">
		    <label for="InputMailCand">Email</label>
		    <input type="text" class="form-control" name="InputMailCand" value="<%=candidature.getAdresseEmail() %>">
		  </div>
		 
		  <button type="submit" class="btn btn-primary">Valider</button>
		</form>
		<br><br>
		<button class="btn btn-danger" data-toggle="modal" data-target="#messageSuppression">
           <i class="glyphicon glyphicon-remove-sign fa-lg"></i> Supprimer la candidature
        </button>
        
        <div class="modal fade" id="messageSuppression" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                <div class="modal-dialog">
                  <div class="modal-content">
                    <div class="modal-header">
                      <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                      <h4 class="modal-title" id="myModalLabel">Vous être sur le point de supprimer votre candidature<br>et les messages associées.</h4>
                    </div>
                    <div class="modal-body">
                      Attention, cette opération n'est pas réversible !
                    </div>
                    <div class="modal-footer">
                      <button type="button" class="btn btn-default" data-dismiss="modal">Annuler</button>
                      <button type="button" class="btn btn-primary" onclick="window.location.href='template.jsp?action=delete_candidature&id=<%= candidature.getId()%>'">
                        <b>Tout Supprimer</b>
                      </button>
                    </div>
                  </div> <!-- /.modal-content -->
                </div> <!-- /.modal-dialog -->
              </div>
<%
	}
	else if(nom.isEmpty() | cv.isEmpty() | ville.isEmpty() | prenom.isEmpty() | naissance.isEmpty() | mail.isEmpty()){
		erreur = "Aucun des paramétres ne doit être nul";
	}
	else{
		Date dateNaissance = formater2.parse(naissance);
		
		  candidature.setAdressePostale(ville);
		  candidature.setNom(nom);
		  candidature.setCv(cv);
		  candidature.setPrenom(prenom);
		  candidature.setAdresseEmail(mail);
		  candidature.setDateNaissance(dateNaissance);
		  candidature = serviceCandidature.UpdateCandidature(candidature);
		  
		  %>
	        <div class="table-responsive">
	            <small>
	            <table class="table">
	              <tbody>
	                <tr class="success">
	                  <td width="200"><strong>Identifiant (login)</strong></td>
	                  <td>CAND_<%=candidature.getId()%></td>
	                </tr>
	                <tr class="warning">
	                  <td><strong>Nom</strong></td>
	                  <td><%=candidature.getNom()%></td>
	                </tr>
	                <tr class="warning">
	                  <td><strong>Prénom</strong></td>
	                  <td><%=candidature.getPrenom()%></td>
	                </tr>
	                <tr class="warning">
	                  <td><strong>Mail</strong></td>
	                  <td><%=candidature.getAdresseEmail()%></td>
	                </tr>
	                <tr class="warning">
	                  <td><strong>CV</strong></td>
	                  <td><%=candidature.getCv()%></td>
	                </tr>
	                <tr class="warning">
	                  <td><strong>Date de naissance</strong></td>
	                  <td><%=formater.format(candidature.getDateNaissance())%></td>
	                </tr>
	                <tr class="warning">
	                  <td><strong>Qualification</strong></td>
	                  <td><%=candidature.getQualification().getIntitule()%></td>
	                </tr>
	                
	            </table>
	            </small>
	            <br><b><a href="template.jsp">Retour a l'accueil</a></b>      
	        </div>
	          <%
	}
}
else
{
	erreur = "Vous n'êtes pas autorisé à accéder à cette page";
}
if(erreur != null) // Une erreur a été détectée et est affichée.
{
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
 }%>
		        </div> <!-- /.table-responsive -->
		      </div> <!-- /.panel-body -->
		    </div> <!-- /.panel -->
		  </div> <!-- /.col-lg-12 -->
		</div> <!-- /.row -->
