<%@page import="eu.telecom_bretagne.cabinet_recrutement.data.model.Candidature"%>
<%@ page language="java" contentType="text/html" pageEncoding="ISO-8859-1"%>

<%@page import="eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocator,
eu.telecom_bretagne.cabinet_recrutement.service.IServiceOffreEmploi,
eu.telecom_bretagne.cabinet_recrutement.data.model.Qualification,
eu.telecom_bretagne.cabinet_recrutement.data.model.OffreEmploi,
java.util.List,
java.util.Set,
java.text.SimpleDateFormat"%>

<%
	IServiceOffreEmploi serviceOffresEmplois = (IServiceOffreEmploi) ServicesLocator.getInstance().getRemoteInterface("ServiceOffresEmplois");
  List<OffreEmploi> offres = serviceOffresEmplois.listeDesOffres();
  
  SimpleDateFormat formater = new SimpleDateFormat("dd/MM/yy");
  
  Object utilisateur = session.getAttribute("utilisateur");
  String erreur=null;
  int idCand = -1;

  if(utilisateur instanceof Candidature)
  {
	  Candidature candidature = (Candidature) utilisateur;
	  idCand = candidature.getId();
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
              for(OffreEmploi offre : offres){
                  Set <Qualification> offrequal = offre.getQualifications();
        	      String qalif_candi = candidature.getQualification().toString();
        	      String s = "";
        	      
        	      for (Qualification q : offrequal) {
        	    	s = s + q;  
        	      }
        	      
        	      System.out.println("" + s);
        	      System.out.println("" + qalif_candi);
        	      
        	      
        	      if(s.contains(qalif_candi)) {
              %>
                <tr>
                 <td>N°<%=offre.getId()%></td>
                 <td><%=offre.getTitre()%></td>
                 <td><%=offre.getEntreprise().getNom()%></td>
                 <td><%
                 for (Qualification q : offrequal)
                 {%>
                	 <%=q.getIntitule()%>
                 <%
                 }
                 %>
                 </td>
                 <td><%=formater.format(offre.getDateDepot())%></td>
                  <td align="center"><a href="template.jsp?action=infos_offre&id=<%=offre.getId()%>"><i class="fa fa-eye fa-lg"></i></a></td>
                </tr>
                <%
              }
         }
  }
              %>
            </tbody>
          </table>
        </div> <!-- /.table-responsive -->
      </div> <!-- /.panel-body -->
    </div> <!-- /.panel -->
  </div> <!-- /.col-lg-12 -->
</div> <!-- /.row -->
