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

List<SecteurActivite> allsecteurs = serviceSecteurActivite.listeDesSecteurActivites();
List<Qualification> allqualifications = serviceQualification.listeDesQualifications();

SimpleDateFormat formater = new SimpleDateFormat("dd-MM-yyyy");

String erreur = null;
String titre = request.getParameter("InputTitreOffre");
String desc = request.getParameter("InputDescOffre");
String profil = request.getParameter("InputProfilOffre");
String qual = request.getParameter("InputQualOffre");
String[] secteurInput = request.getParameterValues("InputSecteurOffre");

Set<SecteurActivite> secteurs = new HashSet<SecteurActivite>();
int idSec=1;

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

Object utilisateur = session.getAttribute("utilisateur");

%>
<div class="row">
  <div class="col-lg-12">
    <div class="panel panel-default">
      <div class="panel-heading"><h3><i class="fa fa-th"></i> Nouvelle offre</h3></div> <!-- /.panel-heading -->
      <div class="panel-body">
        <%

if(utilisateur instanceof Entreprise)
{
	Entreprise entreprise = (Entreprise) utilisateur;
	if(titre==null & desc==null & profil==null & qual==null & secteurInput==null){
		%>
		<form action="template.jsp?action=add_offre" method="post">
		  <div class="form-group">
		    <label for="InputTitreOffre">Titre</label>
		    <input type="text" class="form-control" name="InputTitreOffre" aria-describedby="emailHelp" placeholder="Titre de l'offre">
		  </div>
		  <div class="form-group">
		    <label for="InputDescOffre">Descriptif</label>
		    <textarea class="form-control" placeholder="Descriptif de l'offre" rows="5" name="InputDescOffre"></textarea>
		  </div>
		  <div class="form-group">
		    <label for="InputProfilOffre">Profil recherché</label>
		    <input type="text" class="form-control" name="InputProfilOffre" placeholder="Indiquer ici le profil recherché">
		  </div>
		  <div class="form-group">
				  <label for="InputSecteurOffre">Secteur activité :</label>			 
				    <%			  
				     for (SecteurActivite q : allsecteurs)
	                 {%>
	                	 <INPUT type="checkbox" name="InputSecteurOffre" value="<%=q.getId()%>"> <%=q.getIntitule() %>
	                 <%
	                 }%>
	               </select>			 
				</div>
				<div class="form-group">
				  <label for="InputQualOffre">Qualification demandé :</label>
				  <select class="form-control" id="sel1" name="InputQualOffre">
				    <%			  
				     for (Qualification k : allqualifications)
	                 {%>
	                	 <option name="InputQualOffre" value="<%=k.getId()%>"><%=k.getIntitule() %></option>
	                 <%
	                 }%>
	               </select>			 
				</div>
		  <button type="submit" class="btn btn-primary">Valider</button>
		</form>
		<%
	}
	else if(titre.isEmpty() | desc.isEmpty() | profil.isEmpty() | secteurs.isEmpty()){
		erreur = "Aucun des paramétres ne doit être nul, pensez a bien coché un secteur";
	}
	else{
	      Date date = new Date();
	      int idQual = 1;
	      
	      try{
	    	  idQual=Integer.parseInt(qual);
	      }
	      catch(Exception e){
	    	  erreur ="Erreur sur la qualification, l'id ("+qual+")";
	      }
	      
	      if(erreur==null){
		      Qualification qualification = serviceQualification.getQualification(idQual);
		      
			  OffreEmploi offre = new OffreEmploi(titre, desc, profil, entreprise, date, qualification, secteurs);
			  offre = serviceOffre.CreationOffre(offre);
			  
			  %>
		      	<p>Page création</p>
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
		                	 <%=s.getIntitule()%>
		                 <%
		                 }
		                 %>
		                 </td>
		              </tr>
		            </tbody>
		          </table>
		          </small>      
		      </div>
		        <%
	      }
}
	} else{
		erreur = "Connectez-vous avec votre entreprise pour ajouter une offre";
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
         <br><b><a href="template.jsp?action=add_offre">Retour a la page de création</a></b>
       </div> <!-- /.row col-xs-offset-1 col-xs-10 -->
       <%
       }%>		
        </div> <!-- /.table-responsive -->
      </div> <!-- /.panel-body -->
    </div> <!-- /.panel -->
  </div> <!-- /.col-lg-12 -->
</div> <!-- /.row -->
