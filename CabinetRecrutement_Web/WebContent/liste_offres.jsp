<%@ page language="java" contentType="text/html" pageEncoding="ISO-8859-1"%>

<%@page import="eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocator,
eu.telecom_bretagne.cabinet_recrutement.service.IServiceOffreEmploi,
eu.telecom_bretagne.cabinet_recrutement.data.model.Qualification,
eu.telecom_bretagne.cabinet_recrutement.data.model.OffreEmploi,
java.util.List,
java.util.Set,
java.text.SimpleDateFormat"%>

<%
  IServiceOffreEmploi serviceOffresEmplois = (IServiceOffreEmploi) ServicesLocator.getInstance().getRemoteInterface("ServiceOffreEmploi");
  List<OffreEmploi> offres = serviceOffresEmplois.listeDesOffres();
  
  SimpleDateFormat formater = new SimpleDateFormat("dd/MM/yy");
%>

<div class="row">
  <div class="col-lg-12">
    <div class="panel panel-default">
      <div class="panel-heading"><h3><i class="fa fa-th"></i> Liste de toutes les offres référencées </h3></div> <!-- /.panel-heading -->
      <div class="panel-body">
        <div class="dataTable_wrapper">
          <table class="table table-striped table-bordered table-hover" id="dataTables-example">
            <!--
              Nom des colonnes
            -->
            <thead>
              <tr>
                <th>Numéro d'offre</th>
                <th>Titre</th>
                <th>Entreprise</th>
                <th>Qualification requise</th>
                <th>Date de dépôt</th>
                <th>Informations</th>
              </tr>
            </thead>
            <!--
              Contenu du tableau
            -->
            <tbody>
              <%
              for(OffreEmploi offre : offres)
              {%>
                <tr>
                 <td>N°<%=offre.getId()%></td>
                 <td><%=offre.getTitre()%></td>
                 <td><%=offre.getEntreprise().getNom()%></td>
                 <td><%=offre.getQualifications().getIntitule()%></td>
                 <td><%=formater.format(offre.getDateDepot())%></td>
                  <td align="center"><a href="template.jsp?action=infos_offre&id=<%=offre.getId()%>"><i class="fa fa-eye fa-lg"></i></a></td>
                </tr>
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
