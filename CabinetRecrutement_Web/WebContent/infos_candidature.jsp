<%@page import="java.util.Set"%>
<%@page import="eu.telecom_bretagne.cabinet_recrutement.data.model.SecteurActivite"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="eu.telecom_bretagne.cabinet_recrutement.data.model.Candidature"%>
<%@page import="eu.telecom_bretagne.cabinet_recrutement.service.ServiceCandidature"%>
<%@page import="eu.telecom_bretagne.cabinet_recrutement.service.IServiceCandidature"%>
<%@ page language="java" contentType="text/html" pageEncoding="ISO-8859-1"%>

<%@page import="eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocator,
                eu.telecom_bretagne.cabinet_recrutement.front.utils.Utils,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceEntreprise,
                eu.telecom_bretagne.cabinet_recrutement.data.model.Entreprise"%>

<%
  String erreur = null;
  String idStringValue = request.getParameter("id");
  int id = -1;
  Candidature candidature = null;
  
  SimpleDateFormat formater = new SimpleDateFormat("dd/MM/yy");
  
  if(idStringValue == null)
  {
    erreur="Aucun identifiant de candidature n'est fourni dans la demande.";
  }
  else
  {
    try
    {
      id = new Integer(idStringValue);
      // C'est OK : on a bien un id
      IServiceCandidature servicecandidature = (IServiceCandidature) ServicesLocator.getInstance().getRemoteInterface("ServiceCandidature");
      candidature = servicecandidature.getCandidature(id);
      if(candidature == null)
      {
        erreur="Aucune candidature ne correspond à cet identifiant : " + id;
      }
    }
    catch(NumberFormatException e)
    {
      erreur = "La valeur de l'identifiant n'est pas numérique";
    }
  }
%>

<div class="row">
  <div class="col-lg-12">
    <div class="panel panel-default">
      <div class="panel-heading"><h3><i class="fa fa-th"></i> Informations sur le candidat</h3></div> <!-- /.panel-heading -->
      <div class="panel-body">
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
         </div> <!-- /.row col-xs-offset-1 col-xs-10 -->
         <%
         }
        else
        {
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
                  <td><strong>Date de Naissance</strong></td>
                  <td><%=candidature.getDateNaissance()%></td>
                </tr>
                 <tr class="warning">
                  <td><strong>Adresse postale (ville)</strong></td>
                  <td><%=candidature.getAdressePostale()%></td>
                </tr>
                 <tr class="warning">
                  <td><strong>Email</strong></td>
                  <td><%=candidature.getAdresseEmail()%></td>
                </tr>
                  <tr class="warning">
                  <td><strong>Date de depot</strong></td>
                  <td><%=formater.format(candidature.getDateDepot())%></td>
                </tr>
                  <tr class="warning">
                  <td><strong>CV</strong></td>
                  <td><%=candidature.getCv()%></td>
                </tr>
                  <tr class="warning">
                  <td><strong>Secteur d'activité</strong></td>
                  <%
                 Set<SecteurActivite> candidatureSecteur = candidature.getSecteurActivites();
                 for (SecteurActivite q : candidatureSecteur)
                 {%>
                	 <li><%=q.getIntitule()%></li>
                 <%
                 }
                 %>
                 <tr class="warning">
                  <td><strong>Qualification</strong></td>
                  <td><%=candidature.getQualification().getIntitule()%></td>
              </tbody>
            </table>
            </small>
            <br><b><a href="template.jsp">Retour a l'accueil</a></b>       
        </div>
          <%
        }
        %>
      </div> <!-- /.panel-body -->
    </div> <!-- /.panel -->
  </div> <!-- /.col-lg-12 -->
</div> <!-- /.row -->
