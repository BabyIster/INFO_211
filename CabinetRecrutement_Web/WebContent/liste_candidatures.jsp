<%@ page language="java" contentType="text/html" pageEncoding="ISO-8859-1"%>

<%@page import="eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocator,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceCandidature,
                eu.telecom_bretagne.cabinet_recrutement.data.model.Candidature,
                java.util.List"%>

<%
IServiceCandidature serviceCandidature = (IServiceCandidature) ServicesLocator.getInstance().getRemoteInterface("ServiceCandidature");
  List<Candidature> candidatures = serviceCandidature.listCandidatures();
%>

<div class="row">
  <div class="col-lg-12">
    <div class="panel panel-default">
      <div class="panel-heading"><h3><i class="fa fa-th"></i> Liste des candidatures référencées </h3></div> <!-- /.panel-heading -->
      <div class="panel-body">
        <div class="dataTable_wrapper">
          <table class="table table-striped table-bordered table-hover" id="dataTables-example">
            <!--
              Nom des colonnes
            -->
            <thead>
              <tr>
                <th>Nom</th>
                <th>Prénom</th>
                <th>Date de naissance </th>
                <th>Adresse postale </th>
                <th>Adresse email</th>
                <th>CV</th>
                <th>Date de publication</th>
                <th>Qualification</th>
                <th>Secteur d'activité</th>
                
              </tr>
            </thead>
            <!--
              Contenu du tableau
            -->
            <tbody>
              <%
              for(Candidature candidature : candidatures)
              {
                %>
                <tr>
                 <td><%=candidature.getNom()%></td>
                 <td><%=candidature.getPrenom()%></td>
                 <td><%=candidature.getDateNaissance()%></td>
                 <td><%=candidature.getAdressePostale()%></td>
                 <td><%=candidature.getAdresseEmail()%></td>
                 <td><%=candidature.getCv()%></td>
                 <td><%=candidature.getDateDepot()%></td>               
                 <td><%=candidature.getQualification().getIntitule()%></td>
                 <td>SOOOOOOON BITCH </td>
                 
                 <td>           
                <%
              }
              %>
            </tbody>
          </table>
        </div> <!-- /.table-responsive -->
      </div> <!-- /.panel-body -->
    </div> <!-- /.panel -->
  </div> <!-- /.col-lg-12 -->
</div> <!-- /.row -->
