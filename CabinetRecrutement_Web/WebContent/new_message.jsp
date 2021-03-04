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
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceMessageCand,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceMessageOffre,
                
                eu.telecom_bretagne.cabinet_recrutement.front.utils.Utils,
                java.util.List,
                java.util.Date,
                java.text.SimpleDateFormat"%>

<%
String erreur = null;
Object utilisateur = session.getAttribute("utilisateur");

IServiceOffreEmploi serviceOffresEmplois = (IServiceOffreEmploi) ServicesLocator.getInstance().getRemoteInterface("ServiceOffreEmploi");
IServiceEntreprise serviceEntreprise = (IServiceEntreprise) ServicesLocator.getInstance().getRemoteInterface("ServiceEntreprise");
IServiceCandidature serviceCandidature = (IServiceCandidature) ServicesLocator.getInstance().getRemoteInterface("ServiceCandidature");
IServiceMessageCand serviceMessageCand = (IServiceMessageCand) ServicesLocator.getInstance().getRemoteInterface("ServiceMessageCand");
IServiceMessageOffre serviceMessageOffre = (IServiceMessageOffre) ServicesLocator.getInstance().getRemoteInterface("ServiceMessageOffre");

SimpleDateFormat formater = new SimpleDateFormat("dd/MM/yy");

String inputExpediteur = request.getParameter("exp");
String inputDestinataire = request.getParameter("dest");

String formExpediteur = request.getParameter("formExpediteur");
String formDestinataire = request.getParameter("formDestinataire");
String message = request.getParameter("corps_message");
String envoi = request.getParameter("envoi");

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
if(envoi != null){
	try {
		  idExp = new Integer(formExpediteur);
		  idDest = new Integer(formDestinataire);
	}
	catch(NumberFormatException e)
	{
	erreur = "Les id du destinataire et/ou de l'expéditeur ne sont pas numérique";
	}
}
if(envoi != null & erreur == null){
	if(message == null){
		erreur = "Le message ne peut_pas être nul";
	}
	else if(utilisateur instanceof Candidature)
	{
	  candidatUser = (Candidature) utilisateur;
	}
	else if(utilisateur instanceof Entreprise)
	{
	  entreprise = (Entreprise) utilisateur;
	  offre = serviceOffresEmplois.getOffre(idExp);
	  candidat = serviceCandidature.getCandidature(idDest);
	  
	  Date date = new Date();
	  MessageOffreEmploi messageOffre = new MessageOffreEmploi(message, date, offre, candidat);
	  
	  %>
	  <div class="table-responsive">
          <small>
          <table class="table">
            <tbody>
              <tr class="success">
                <td width="200"><strong>Identifiant du message</strong></td>
                <td><%=messageOffre.getId()%></td>
              </tr>
              <tr class="warning">
                <td><strong>Candidature</strong></td>
                <td><%=messageOffre.getCandidature().getPrenom()%> <%=messageOffre.getCandidature().getNom()%>(CAND_<%=messageOffre.getCandidature().getId()%>)</td>
              </tr>
              <tr class="warning">
                <td><strong>Offre d'emploi</strong></td>
                <td><%=messageOffre.getOffreEmploi().getTitre()%>(<%=messageOffre.getOffreEmploi().getEntreprise().getNom()%>)</td>
              </tr>
              <tr class="warning">
                <td><strong>Date de'envoi)</strong></td>
                <td><%=formater.format(messageOffre.getDateEnvoi())%></td>
              </tr>
              <tr class="warning">
                <td><strong>Message</strong></td>
                <td><%=Utils.text2HTML(messageOffre.getCorpsMessage())%></td>
              </tr>
            </tbody>
          </table>
          </small>      
      </div>
	  <%
	}
}
else{
	
	if(inputExpediteur == null | inputDestinataire ==null){
		erreur = "Les id du destinataire et/ou de l'expéditeur sont null";
	}
	
	try {
		  idExp = new Integer(inputExpediteur);
		  idDest = new Integer(inputDestinataire);
	}
	catch(NumberFormatException e)
	{
	erreur = "Les id du destinataire et/ou de l'expéditeur ne sont pas numérique";
	}
	
	if(erreur == null)
	{
	  if(utilisateur instanceof Candidature)
		{
		  candidatUser = (Candidature) utilisateur;
		  
		  offre = serviceOffresEmplois.getOffre(idDest);
		  candidat = serviceCandidature.getCandidature(idExp);
		  
			if(offre == null){
				erreur = "L'offre est introuvable";
			}
			if(candidat == null){
				erreur = " Le candidat est introuvable";
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
		  else if(candidat == null){
				erreur = " Le candidat est introuvable";
			}
		  else if(offre.getEntreprise().getId() != idEnt){
				erreur = "Vous ne pouvez envoyé des messages uniquement avec votre compte";
			}
			
		}
	  else{
		  erreur="Impossible de vous identifier";
	  }
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
			expediteur = candidat.getPrenom() + " " + candidat.getNom();
			
			destinataire = entreprise.getNom() + " <br>(" + offre.getTitre() + ")";
			
			String type = "ent";
		}
		if(utilisateur instanceof Entreprise)
		{
			
			expediteur = entreprise.getNom() + " <br>(" + offre.getTitre() + ")";
			
			destinataire = candidat.getPrenom() + " " + candidat.getNom();
			
			String type = "cand";
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
	              
	              <form role="form" action="template.jsp?action=new_message" method="post">
	                <input type="hidden" name="envoi" value="nouveau_message">
	                <input type="hidden" name="formExpediteur" value="<%=expediteur %>">
	                <input type="hidden" name="formDestinataire" value="<%=destinataire %>">
	                <div class="form-group">
	                  <textarea class="form-control" placeholder="Contenu du message" rows="5" name="corps_message" required></textarea>
	                </div>
	                <div class="text-center">
	                  <button type="submit" class="btn btn-success btn-circle btn-lg" name="submit-insertion"><i class="fa fa-check"></i></button>
	                </div>
	              </form>
	            </div>
	            <%
	}
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