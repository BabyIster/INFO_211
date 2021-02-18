<%@ page language="java" contentType="text/html" pageEncoding="ISO-8859-1"%>

<%@page import="eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocator,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceEntreprise,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceCandidature,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceOffresEmplois"%>

<%
  IServiceEntreprise serviceEntreprise = (IServiceEntreprise) ServicesLocator.getInstance().getRemoteInterface("ServiceEntreprise");
  IServiceCandidature serviceCandidature = (IServiceCandidature) ServicesLocator.getInstance().getRemoteInterface("ServiceCandidature");
  IServiceOffresEmplois serviceOffre = (IServiceOffresEmplois) ServicesLocator.getInstance().getRemoteInterface("ServiceOffresEmplois");

  int nbEntreprises  = serviceEntreprise.listeDesEntreprises().size();
  int nbOffres       = serviceOffre.listeDesOffres().size();
  int nbCandidatures = serviceCandidature.listCandidatures().size();
%>

<div class="row">

<div class="col-lg-4 col-md-6">
    <div class="panel panel-primary">
      <div class="panel-heading">
        <div class="row">
          <div class="col-xs-3">
            <i class="fa fa-th fa-5x"></i>
          </div>
          <div class="col-xs-9 text-right">
            <div class="huge"><%=nbCandidatures%></div>
            <div><%=(nbCandidatures <=1 ? "candidature" : "candidatures")%></div>
          </div>
        </div>
      </div>
      <a href="template.jsp?action=liste_candidatures">
        <div class="panel-footer">
          <span class="pull-left">Liste des candidatures</span>
          <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
          <div class="clearfix"></div>
        </div>
      </a> 
       <a href="template.jsp?action=add_candidature">
        <div class="panel-footer">
          <span class="pull-left">Ajouter une candidature</span>
          <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
          <div class="clearfix"></div>
        </div>
      </a> 
    </div>
  </div>
  
  <div class="col-lg-4 col-md-6">
    <div class="panel panel-primary">
      <div class="panel-heading">
        <div class="row">
          <div class="col-xs-3">
            <i class="fa fa-th fa-5x"></i>
          </div>
          <div class="col-xs-9 text-right">
            <div class="huge"><%=nbEntreprises%></div>
            <div><%=(nbEntreprises <=1 ? "entreprise" : "entreprises")%></div>
          </div>
        </div>
      </div>
      <a href="template.jsp?action=liste_entreprises">
        <div class="panel-footer">
          <span class="pull-left">Liste des entreprises</span>
          <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
          <div class="clearfix"></div>
        </div>
      </a>
      <a href="template.jsp?action=add_entreprise">
        <div class="panel-footer">
          <span class="pull-left">Ajouter une entreprise</span>
          <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
          <div class="clearfix"></div>
        </div>
      </a>  
    </div>
  </div>
  
  <div class="col-lg-4 col-md-6">
    <div class="panel panel-primary">
      <div class="panel-heading">
        <div class="row">
          <div class="col-xs-3">
            <i class="fa fa-th fa-5x"></i>
          </div>
          <div class="col-xs-9 text-right">
            <div class="huge"><%=nbOffres%></div>
            <div><%=(nbOffres <=1 ? "offre" : "offres")%></div>
          </div>
        </div>
      </div>
      <a href="template.jsp?action=liste_offres">
        <div class="panel-footer">
          <span class="pull-left">Liste des offres</span>
          <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
          <div class="clearfix"></div>
        </div>
      </a> 
    </div>
  </div>
</div> <!-- /.row -->
