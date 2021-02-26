<%@ page language="java" contentType="text/html" pageEncoding="ISO-8859-1"%>


<%@page import="eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocator,
                eu.telecom_bretagne.cabinet_recrutement.front.utils.Utils,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceCandidature,
                eu.telecom_bretagne.cabinet_recrutement.data.model.Candidature,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceQualification,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceSecteurActivite,
                eu.telecom_bretagne.cabinet_recrutement.data.model.Qualification,
                eu.telecom_bretagne.cabinet_recrutement.data.model.SecteurActivite,
                java.util.Date,
                java.util.Set,
                java.util.HashSet,
                java.text.SimpleDateFormat,
                java.text.DateFormat"%>

<%
IServiceCandidature servicecandidature = (IServiceCandidature) ServicesLocator.getInstance().getRemoteInterface("ServiceCandidature");
IServiceQualification serviceQualification = (IServiceQualification) ServicesLocator.getInstance().getRemoteInterface("ServiceQualification");
IServiceSecteurActivite serviceSecteurActivite = (IServiceSecteurActivite) ServicesLocator.getInstance().getRemoteInterface("ServiceSecteurActivite");

  String erreur = null;
  int id = -1;
  SimpleDateFormat formater = new SimpleDateFormat("dd-MM-yyyy");
  
  String prenom = request.getParameter("InputPrenom");
  String nom = request.getParameter("InputNom");
  String ville = request.getParameter("Inputadresse");
  String dateNaissance = request.getParameter("Inputdate");
  String mail = request.getParameter("Inputmail");
  String cv = request.getParameter("InputCV");
  
  String Qualification = request.getParameter("InputQualification");
  String Secteur = request.getParameter("InputSecteur");
  
  System.out.println("Secteur: " + Secteur);

  Date dateNaissanceFormat = formater.parse(dateNaissance);

  Qualification qualification = serviceQualification.getQualificationByName(Qualification);
  Set<SecteurActivite> secteur = new HashSet<SecteurActivite>();
  secteur.add(serviceSecteurActivite.getSecteurActivite(Integer.parseInt(Secteur)));

  Candidature candidature = new Candidature(prenom, nom, dateNaissanceFormat, ville, mail, cv, dateNaissanceFormat, qualification, secteur);
  candidature = servicecandidature.CreationCandidature(candidature);
  
%>

<div class="row">
  <div class="col-lg-12">
    <div class="panel panel-default">
      <div class="panel-heading"><h3><i class="fa fa-th"></i> Success, candidature crée :</h3></div> <!-- /.panel-heading -->
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
                  <td><strong>Prenom</strong></td>
                  <td><%=candidature.getPrenom()%></td>
                </tr>
                <tr class="warning">
                  <td><strong>Nom</strong></td>
                  <td><%=candidature.getNom()%></td>
                </tr>
                <tr class="warning">
                  <td><strong>Date de naissance</strong></td>
                  <td><%=formater.format(candidature.getDateNaissance())%></td>
                </tr>
                <tr class="warning">
                  <td><strong>Adresse postale (ville)</strong></td>
                  <td><%=candidature.getAdressePostale()%></td>
                </tr>
                <tr class="warning">
                  <td><strong>CV</strong></td>
                  <td><%=Utils.text2HTML(candidature.getCv())%></td>
                </tr>
                <tr class="warning">
                  <td><strong>Date de dépot</strong></td>
                  <td><%=formater.format(candidature.getDateDepot())%></td>
                </tr>
                <tr class="warning">
                  <td><strong>Qualification</strong></td>
                  <td><%=candidature.getQualification().getIntitule()%></td>
                </tr>
                <tr class="warning">
                  <td><strong>Secteur d'activité</strong></td>
                  <td><%=candidature.getSecteurActiviteString()%></td>
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