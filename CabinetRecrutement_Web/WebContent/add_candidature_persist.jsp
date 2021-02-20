<%@ page language="java" contentType="text/html" pageEncoding="ISO-8859-1"%>

<%@page import="eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocator,
                eu.telecom_bretagne.cabinet_recrutement.front.utils.Utils,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceCandidature,
                eu.telecom_bretagne.cabinet_recrutement.data.model.Candidature,
                eu.telecom_bretagne.cabinet_recrutement.data.model.Qualification,
                eu.telecom_bretagne.cabinet_recrutement.data.model.SecteurActivite,
                java.util.Date,
                java.util.Set,
                java.text.SimpleDateFormat,
                java.text.DateFormat"%>

<%

  IServiceCandidature serviceCandidature = (IServiceCandidature) ServicesLocator.getInstance().getRemoteInterface("ServiceCandidature");

  String erreur = null;
  int id = -1;
  //SimpleDateFormat formater = new SimpleDateFormat("dd/MM/yy");
  
  String prenom = request.getParameter("prenom");
  String nom = request.getParameter("nom");
  String cv = request.getParameter("cv");
  String ville = request.getParameter("adresse");
  String dateNaissance = request.getParameter("date");
  //Date dateNaissanceFormat = formater.parse(dateNaissance);
  Date dateNaissanceFormat = new Date(0,0,0);

  String mail = request.getParameter("mail");
  Qualification qualification = null;
  Set<SecteurActivite> secteur = null;
  
  @SuppressWarnings("deprecation")
  Date today = new Date(0,0,0);
  
  Candidature Candidature = new Candidature(prenom, nom, dateNaissanceFormat, ville, mail, cv, today, qualification, secteur);
  Candidature = serviceCandidature.CreationCandidature(Candidature);
%>

<div class="row">
  <div class="col-lg-12">
    <div class="panel panel-default">
      <div class="panel-heading"><h3><i class="fa fa-th"></i> Success ,Candidature cr�e :</h3></div> <!-- /.panel-heading -->
      <div class="panel-body">
        <%
        if(erreur != null) // Une erreur a �t� d�tect�e et est affich�e.
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
                  <td>CAND_<%=Candidature.getId()%></td>
                </tr>
                <tr class="warning">
                  <td><strong>Prenom</strong></td>
                  <td><%=Candidature.getPrenom()%></td>
                </tr>
                <tr class="warning">
                  <td><strong>Nom</strong></td>
                  <td><%=Candidature.getNom()%></td>
                </tr>
                <tr class="warning">
                  <td><strong>Date de naissance</strong></td>
                  <td><%=Candidature.getDateNaissance()%></td>
                </tr>
                <tr class="warning">
                  <td><strong>Adresse postale (ville)</strong></td>
                  <td><%=Candidature.getAdressePostale()%></td>
                </tr>
                <tr class="warning">
                  <td><strong>CV</strong></td>
                  <td><%=Utils.text2HTML(Candidature.getCv())%></td>
                </tr>
                <tr class="warning">
                  <td><strong>Date de d�pot</strong></td>
                  <td><%=Candidature.getDateDepot()%></td>
                </tr>
              </tbody>
            </table>
            </small>      
        </div>
          <%
        }
        %>
      </div> <!-- /.panel-body -->
    </div> <!-- /.panel -->
  </div> <!-- /.col-lg-12 -->
</div> <!-- /.row -->
