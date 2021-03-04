<%@ page language="java" contentType="text/html" pageEncoding="ISO-8859-1"%>

<%@page import="eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocator,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceEntreprise,
                eu.telecom_bretagne.cabinet_recrutement.data.model.Entreprise,
                eu.telecom_bretagne.cabinet_recrutement.data.model.OffreEmploi,
                eu.telecom_bretagne.cabinet_recrutement.data.model.Candidature,
                eu.telecom_bretagne.cabinet_recrutement.data.model.MessageCandidature,
                eu.telecom_bretagne.cabinet_recrutement.data.model.MessageOffreEmploi,
                eu.telecom_bretagne.cabinet_recrutement.front.utils.Utils,
                java.util.List,
                java.text.SimpleDateFormat"%>

<%
String erreur = null;
Object utilisateur = session.getAttribute("utilisateur");

SimpleDateFormat formater = new SimpleDateFormat("dd/MM/yy");

if(utilisateur == null){
	erreur = "Vous devez vous connectez pour accèder aux messages";
}
%>

<div class="row">
  <div class="col-lg-12">
    <div class="panel panel-default">
      <div class="panel-heading"><h3><i class="fa fa-envelope"></i> Liste des messages</h3></div> <!-- /.panel-heading -->
      <div class="panel-body">

        <div class="panel-group" id="accordion">

          <!-- Liste des messages reçus -->
          <div class="panel panel-default">
            <div class="panel-heading">
              <h4 class="panel-title">
                <a data-toggle="collapse" data-parent="#accordion" href="#collapseMessagesRecus" aria-expanded="true"><i class="glyphicon glyphicon-import"></i> Message reçus</a>
              </h4>
            </div>
            <div id="collapseMessagesRecus" class="panel-collapse collapse in" aria-expanded="true" style="">
              <div class="panel-body">
                
                  <small>
                    <div class="dataTable_wrapper">
                     <table class="table table-striped table-bordered table-hover" "="">
                       <thead>
                         <tr>
                           <th>Identifiant</th>
                           <th>Expéditeur</th>
                           <th>Offre</th>
                           <th>Date d'envoi</th>
                           <th>Message</th>
                         </tr>
                       </thead>
                       <tbody>
                       <%
                         if(utilisateur instanceof Entreprise)
							{
							Entreprise entreprise = (Entreprise) utilisateur;
								for(OffreEmploi o : entreprise.getOffreEmplois()){
									for(MessageCandidature m : o.getMessageCandidatures()){
							%>
                           <tr>
                             <td><%=m.getId() %></td>
                             <td><a href="template.jsp?action=infos_candidature&id=<%=m.getCandidature().getId() %>"><%=m.getCandidature().getPrenom() %><%=m.getCandidature().getNom() %></a></td>
                             <td><a href="template.jsp?action=infos_offre&id=<%=o.getId() %>"><%=o.getTitre() %></a></td>
                             <td><%=formater.format(m.getDateEnvoi()) %></td>
                             <td><%=m.getCorpsMessage() %></td>
                           </tr>
                           <%
									}
                           }
                       }
                           %>
                           
                           <%
                         if(utilisateur instanceof Candidature)
							{
							Candidature candidat = (Candidature) utilisateur;
							for(MessageOffreEmploi m : candidat.getMessageOffreEmplois()){
							%>
                           <tr>
                             <td><%=m.getId() %></td>
                             <td><a href="template.jsp?action=infos_entreprise&id=<%=m.getOffreEmploi().getEntreprise().getId() %>"><%=m.getOffreEmploi().getEntreprise().getNom() %></a></td>
                             <td><a href="template.jsp?action=infos_offre&id=<%=m.getOffreEmploi().getId() %>"><%=m.getOffreEmploi().getTitre() %></a></td>
                             <td><%=formater.format(m.getDateEnvoi()) %></td>
                             <td><%=m.getCorpsMessage() %></td>
                           </tr>
                           <%
									}
                           }
                           %>
                       </tbody>
                     </table>
                   </div> <!-- /.table-responsive -->
                 </small>
                 
              </div>
            </div>
          </div>

          <!-- Liste des messages envoyés -->
          <div class="panel panel-default">
            <div class="panel-heading">
              <h4 class="panel-title">
                <a data-toggle="collapse" data-parent="#accordion" href="#collapseMessagesEnvoyes" class="collapsed" aria-expanded="false"><i class="glyphicon glyphicon-export"></i> Messages envoyés</a>
              </h4>
            </div>
            <div id="collapseMessagesEnvoyes" class="panel-collapse collapse in">
              <div class="panel-body">
                
                  <small>
                    <div class="dataTable_wrapper">
                     <table class="table table-striped table-bordered table-hover" "="">
                       <thead>
                         <tr>
                           <th>Identifiant</th>
                           <th>Destinataire</th>
                           <th>Offre</th>
                           <th>Date d'envoi</th>
                           <th>Message</th>
                         </tr>
                       </thead>
                       <tbody>
                         <%
                         if(utilisateur instanceof Entreprise)
							{
							Entreprise entreprise = (Entreprise) utilisateur;
								for(OffreEmploi o : entreprise.getOffreEmplois()){
									for(MessageOffreEmploi m : o.getMessageOffreEmplois()){
							%>
                        <tr>
                          <td><%=m.getId() %></td>
                          <td><a href="template.jsp?action=infos_candidature&id=<%=m.getCandidature().getId() %>"><%=m.getCandidature().getPrenom() %><%=m.getCandidature().getNom() %></a></td>
                          <td><a href="template.jsp?action=infos_offre&id=<%=o.getId() %>"><%=o.getTitre() %></a></td>
                          <td><%=formater.format(m.getDateEnvoi()) %></td>
                          <td><%=m.getCorpsMessage() %></td>
                        </tr>
                        <%
									}
                        }
                    }
                        %>
                           
                           <%
                         if(utilisateur instanceof Candidature)
							{
							Candidature candidat = (Candidature) utilisateur;
							for(MessageCandidature m : candidat.getMessageCandidatures()){
							%>
                           <tr>
                             <td><%=m.getId() %></td>
                             <td><a href="template.jsp?action=infos_entreprise&id=<%=m.getOffreEmploi().getEntreprise().getId() %>"><%=m.getOffreEmploi().getEntreprise().getNom() %></a></td>
                             <td><a href="template.jsp?action=infos_offre&id=<%=m.getOffreEmploi().getId() %>"><%=m.getOffreEmploi().getTitre() %></a></td>
                             <td><%=formater.format(m.getDateEnvoi()) %></td>
                             <td><%=m.getCorpsMessage() %></td>
                           </tr>
                           <%
									}
                           }
                           %>
                       </tbody>
                     </table>
                     <%
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
                 </small>
                 
              </div>
            </div>
          </div>
          
        </div> <!-- /.panel-group -->

      </div> <!-- /.panel-body -->
    </div> <!-- /.panel -->
  </div> <!-- /.col-lg-12 -->
</div>