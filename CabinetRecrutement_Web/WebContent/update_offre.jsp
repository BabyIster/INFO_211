<%@ page language="java" contentType="text/html" pageEncoding="ISO-8859-1"%>

<%@page import="eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocator,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceEntreprise,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceOffreEmploi,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceQualification,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceSecteurActivite,
                eu.telecom_bretagne.cabinet_recrutement.front.utils.Utils,
                eu.telecom_bretagne.cabinet_recrutement.data.model.Entreprise,
                eu.telecom_bretagne.cabinet_recrutement.data.model.OffreEmploi,
                eu.telecom_bretagne.cabinet_recrutement.data.model.Qualification,
                eu.telecom_bretagne.cabinet_recrutement.data.model.SecteurActivite,
                java.util.List,
                java.util.Date,
                java.util.Set,
                java.util.HashSet,
                java.text.SimpleDateFormat,
                java.text.DateFormat"%>

<%
IServiceEntreprise serviceEntreprise = (IServiceEntreprise) ServicesLocator.getInstance().getRemoteInterface("ServiceEntreprise");
IServiceOffreEmploi serviceOffre = (IServiceOffreEmploi) ServicesLocator.getInstance().getRemoteInterface("ServiceOffreEmploi");
IServiceSecteurActivite serviceSecteurActivite = (IServiceSecteurActivite) ServicesLocator.getInstance().getRemoteInterface("ServiceSecteurActivite");
IServiceQualification serviceQualification = (IServiceQualification) ServicesLocator.getInstance().getRemoteInterface("ServiceQualification");

Object utilisateur = session.getAttribute("utilisateur");
String erreur = null;

List<SecteurActivite> allsecteurs = serviceSecteurActivite.listeDesSecteurActivites();
List<Qualification> allqualifications = serviceQualification.listeDesQualifications();

SimpleDateFormat formater = new SimpleDateFormat("dd-MM-yyyy");

String idStringValue = request.getParameter("id");

String titre = request.getParameter("InputTitreOffre");
String desc = request.getParameter("InputDescOffre");
String profil = request.getParameter("InputProfilOffre");
String qual = request.getParameter("InputQualOffre");
String[] secteurInput = request.getParameterValues("InputSecteurOffre");

Set<SecteurActivite> secteurs = new HashSet<SecteurActivite>();
int idSec=1;
OffreEmploi offre=null;
int secBool=0;
if(request.getParameter("InputSecteurOffre")!=null){
		for(String sec : secteurInput){
			try{
				idSec=Integer.parseInt(sec);
			}catch(Exception e){
				erreur = "Probléme sur les secteurs !";
			}
			secteurs.add(serviceSecteurActivite.getSecteurActivite(idSec));
		}
}
if(idStringValue != null){
	try{
		int idOffre=Integer.parseInt(idStringValue);
		offre = serviceOffre.getOffre(idOffre);
	}catch(Exception e){
		erreur = "Probléme avec l'id de l'offre !";
	}
}

%>
<div class="row">
		  <div class="col-lg-12">
		    <div class="panel panel-default">
		      <div class="panel-heading"><h3><i class="fa fa-th"></i> Mettre à jour les informations de l'offre</h3></div> <!-- /.panel-heading -->
		      <div class="panel-body">
		        <div class="dataTable_wrapper">
<%

if(utilisateur instanceof Entreprise)
{
	Entreprise entreprise = (Entreprise) utilisateur;
	
	if(titre==null & desc==null & profil==null & qual==null & secteurInput==null & erreur==null){
		%>  
		  <form action="template.jsp?action=update_offre" method="post">
		  <div class="form-group">
		    <input type="text" class="form-control" aria-describedby="emailHelp" value="Offre numéro : <%=offre.getId() %>" disabled="disabled">
		  </div>
		  <div class="form-group">
		    <label for="InputTitreOffre">Titre</label>
		    <input class="form-control" value="<%=offre.getTitre() %>" name="InputTitreOffre">
		  </div>
		  <div class="form-group">
		    <label for="InputDescOffre">Description</label>
		    <textarea class="form-control" name="InputDescOffre" rows="5"><%=offre.getDescriptif()%></textarea>
		  </div>
		  <div class="form-group">
		    <label for="InputProfilOffre">Profil recherché</label>
		    <input type="text" class="form-control" name="InputProfilOffre" value="<%=offre.getProfilRecherche() %>">
		  </div>
		  <div class="form-group">
			  <label for="InputSecteurOffre">Secteur activité :</label>			 
			    <%			  
			     for (SecteurActivite q : allsecteurs)
	                {
			    	 secBool=0;
	                for (SecteurActivite q2 : secteurs){
	                	if(q.getIntitule().equals(q2.getIntitule()) & secBool==0){
	                		secBool=1;
	                		out.println(q+":"+q2);
	                		%>
	                		<INPUT type="checkbox" name="InputSecteurOffre" value="<%=q.getId()%>" checked="checked"> <%=q.getIntitule() %>
	                		<%
	                	}
	                }
	                if(secBool==0){
	                	%>
	               	 <INPUT type="checkbox" name="InputSecteurOffre" value="<%=q.getId()%>"> <%=q.getIntitule() %>
	                <%
	                }
	               }%>			 
				</div>
				<div class="form-group">
				  <label for="InputQualOffre">Qualification demandé :</label>
				  <select class="form-control" id="sel1" name="InputQualOffre">
				    <%			  
				     for (Qualification k : allqualifications)
	                 {
	                 if(k.getIntitule().equals(offre.getQualifications().getIntitule())){
	                	 %>
	                	 <option selected="selected" name="InputQualOffre" value="<%=k.getId()%>"><%=k.getIntitule() %>
	                	 <%
	                 }
	                 else{
	                	 %>
	                	 <option name="InputQualOffre" value="<%=k.getId()%>"><%=k.getIntitule() %></option>
	                	 
	                 <%
	                 }
	                }%>
	               </select>			 
				</div>
		 
		  <button type="submit" class="btn btn-primary">Valider</button>
		</form>
		<br><br>
		<button class="btn btn-danger" data-toggle="modal" data-target="#messageSuppression">
           <i class="glyphicon glyphicon-remove-sign fa-lg"></i> Supprimer l'offre
        </button>
        
        <div class="modal fade" id="messageSuppression" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                <div class="modal-dialog">
                  <div class="modal-content">
                    <div class="modal-header">
                      <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                      <h4 class="modal-title" id="myModalLabel">Vous être sur le point de supprimer cette offre d'emplois.</h4>
                    </div>
                    <div class="modal-body">
                      Attention, cette opération n'est pas réversible !
                    </div>
                    <div class="modal-footer">
                      <button type="button" class="btn btn-default" data-dismiss="modal">Annuler</button>
                      <button type="button" class="btn btn-primary" onclick="window.location.href='template.jsp?action=delete_offre&id=<%= offre.getId()%>'">
                        <b>Supprimer l'offre</b>
                      </button>
                    </div>
                  </div> <!-- /.modal-content -->
                </div> <!-- /.modal-dialog -->
              </div>
<%
	}
	else if(titre.isEmpty() | desc.isEmpty() | profil.isEmpty() | secteurs.isEmpty()){
		erreur = "Aucun des paramétres ne doit être nul";
	}
	else{
	  int idQual = 1;
      
      try{
    	  idQual=Integer.parseInt(qual);
      }
      catch(Exception e){
    	  erreur ="Erreur sur la qualification, l'id ("+qual+")";
      }
		if(erreur==null){
		  
		  offre.setDescriptif(desc);
		  offre.setProfilRecherche(profil);
		  offre.setTitre(titre);
		  offre.setQualifications(serviceQualification.getQualification(idQual));
		  offre.setSecteurActivites(secteurs);
		  
		  offre = serviceOffre.UpdateOffre(offre);
		  %>
	        <div class="table-responsive">
		          <small>
		          <table class="table">
		            <tbody>
		              <tr class="success">
		                <td width="200"><strong>Identifiant (login)</strong></td>
		                <td>Offre numéro <%=offre.getId()%></td>
		              </tr>
		              <tr class="warning">
		                <td><strong>Nom</strong></td>
		                <td><%=offre.getTitre()%></td>
		              </tr>
		              <tr class="warning">
		                <td><strong>Profil recherché</strong></td>
		                <td><%=offre.getProfilRecherche()%></td>
		              </tr>
		              <tr class="warning">
		                <td><strong>Descriptif</strong></td>
		                <td><%=Utils.text2HTML(offre.getDescriptif())%></td>
		              </tr>
		              <tr class="warning">
		                <td><strong>Date de dépot</strong></td>
		                <td><%=formater.format(offre.getDateDepot())%></td>
		              </tr>
		              <tr class="warning">
		                <td><strong>Qualification requise</strong></td>
		                <td><%=offre.getQualifications().getIntitule()%></td>
		              </tr>
		              <tr class="warning">
		                <td><strong>Secteur d'activité</strong></td>
		                <td>
		                <%
		                 Set <SecteurActivite> secteursList = offre.getSecteurActivites();
		                 for (SecteurActivite s : secteursList)
		                 {%>
		                	 <li><%=s.getIntitule()%></li>
		                 <%
		                 }
		                 %>
		                 </td>
		              </tr>
		            </tbody>
		          </table>
		          </small>
		          <br><b><a href="template.jsp">Retour a l'accueil</a></b>      
		      </div>
	          <%
	}
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
