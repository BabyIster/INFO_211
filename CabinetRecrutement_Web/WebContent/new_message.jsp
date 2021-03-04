<%@ page language="java" contentType="text/html" pageEncoding="ISO-8859-1"%>

<%@page import="eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocator,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceEntreprise,
                eu.telecom_bretagne.cabinet_recrutement.data.model.Entreprise,
                eu.telecom_bretagne.cabinet_recrutement.data.model.OffreEmploi,
                eu.telecom_bretagne.cabinet_recrutement.data.model.Candidature,
                eu.telecom_bretagne.cabinet_recrutement.data.model.MessageCandidature,
                eu.telecom_bretagne.cabinet_recrutement.data.model.MessageOffreEmploi,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceOffreEmploi,
				eu.telecom_bretagne.cabinet_recrutement.service.IServiceEntreprise,
				eu.telecom_bretagne.cabinet_recrutement.service.IServiceCandidature,
                
                eu.telecom_bretagne.cabinet_recrutement.front.utils.Utils,
                java.util.List,
                java.text.SimpleDateFormat"%>

<%
String erreur = null;
Object utilisateur = session.getAttribute("utilisateur");

IServiceOffreEmploi serviceOffresEmplois = (IServiceOffreEmploi) ServicesLocator.getInstance().getRemoteInterface("ServiceOffreEmploi");
IServiceEntreprise serviceEntreprise = (IServiceEntreprise) ServicesLocator.getInstance().getRemoteInterface("ServiceEntreprise");
IServiceCandidature serviceCandidature = (IServiceCandidature) ServicesLocator.getInstance().getRemoteInterface("ServiceCandidature");

SimpleDateFormat formater = new SimpleDateFormat("dd/MM/yy");

String inputExpediteur = request.getParameter("exp");
String inputDestinataire = request.getParameter("dest");

OffreEmploi offre = null;
Candidature candidat = null;
Candidature candidatUser = null;
Entreprise entreprise = null;

String expediteur = null;
String destinataire = null;

int idDest = -1;
int idExp = -1;

if(utilisateur == null){
	erreur = "Vous devez vous connectez pour envoyer des messages";
}
else try
{
  idExp = new Integer(inputExpediteur);
  idDest = new Integer(inputDestinataire);
  
  if(utilisateur instanceof Candidature)
	{
	  candidatUser = (Candidature) utilisateur;
	  
	  offre = serviceOffresEmplois.getOffre(idDest);
	  candidat = serviceCandidature.getCandidature(idExp);
	  
		if(offre == null){
			erreur = "L'offre est introuvable";
		}
		if(candidat == null){
			erreur += " Le candidat est introuvable";
		}
		else if(candidatUser.getId() != idExp){
			erreur = "Vous ne pouvez envoyé des messages uniquement avec votre compte";
		}
		
	}
  else if(utilisateur instanceof Entreprise)
	{
	  entreprise = (Entreprise) utilisateur;
	  
	  offre = serviceOffresEmplois.getOffre(idExp);
	  candidat = serviceCandidature.getCandidature(idDest);
	  
	  int idEnt = entreprise.getId();
	  
	  if(offre == null){
			erreur = "L'offre est introuvable";
		}
	  if(candidat == null){
			erreur += " Le candidat est introuvable";
		}
	  else if(offre.getEntreprise().getId() != idEnt){
			erreur = "Vous ne pouvez envoyé des messages uniquement avec votre compte";
		}
		
	}
  else{
	  erreur="Impossible de vous identifier";
  }
}
catch(NumberFormatException e)
{
  erreur = "Les id du destinataire et/ou de l'expéditeur n'est pas numérique";
}
%>

<div class="row">
  <div class="col-lg-12">
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3><i class="fa fa-envelope"></i>Nouveau message</h3>
      </div> <!-- /.panel-heading -->
      <div class="panel-body">

<%        
if(erreur == null){
	if(utilisateur instanceof Candidature)
	{
		
	}
	if(utilisateur instanceof Entreprise)
	{
		
		expediteur = entreprise.getNom() + " <br>(" + offre.getTitre() + ")";
		
		destinataire = serviceCandidature.getCandidature(idDest).getPrenom();
		destinataire += " " + serviceCandidature.getCandidature(idDest).getNom(); 
	}
%>                            
            <div class="col-lg-offset-2 col-lg-8
                        col-xs-12">

              <div class="alert alert-info">
                <table border="0" align="center">
                  <tbody><tr>
                    <td width="200" align="center">
                      <i class="fa fa-envelope-square fa-2x"></i>
                      <br><%=expediteur %><br>
                    </td>
                    <td width="50" align="center">
                      <img src="images/poste.gif" alt="Camion de la Poste" width="200px">
                    </td>
                    <td width="200" align="center">
                      <i class="fa fa-inbox fa-2x"></i>
                      <br><%=destinataire %><br>
                    </td>
                  </tr>
                </tbody></table>
              </div>
              
              <form role="form" action="template.jsp" method="get">
                <input type="hidden" name="action" value="nouveau_message">
                <input type="hidden" name="action2" value="enregistrer">
                <input type="hidden" name="expediteur" value="<%=expediteur %>">
                <input type="hidden" name="destinataire" value="<%=destinataire %>">
                <div class="form-group">
                  <textarea class="form-control" placeholder="Contenu du message" rows="5" name="corps_message"></textarea>
                </div>
                <div class="text-center">
                  <button type="submit" class="btn btn-success btn-circle btn-lg" name="submit-insertion"><i class="fa fa-check"></i></button>
                </div>
              </form>
            </div>
            <%
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
				  <br><b><a href=javascript:history.go(-1)>Retour en arrière</a></b>  
				</div> <!-- /.row col-xs-offset-1 col-xs-10 -->
				<%
				}%>

      </div> <!-- /.panel-body -->
    </div> <!-- /.panel -->
  </div> <!-- /.col-lg-12 -->
</div>