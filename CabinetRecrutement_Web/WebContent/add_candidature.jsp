<%@ page language="java" contentType="text/html" pageEncoding="ISO-8859-1"%>

<%@page import="eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocator,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceCandidature,
                eu.telecom_bretagne.cabinet_recrutement.data.model.Candidature,
                java.util.List"%>

<%
IServiceCandidature serviceCandidature = (IServiceCandidature) ServicesLocator.getInstance().getRemoteInterface("ServiceCandidature");
  List<Candidature> candidatures = serviceCandidature.listCandidatures();
  
    //Set<SecteurActivite> secteurActivites = new HashSet<SecteurActivite>();
    //SecteurActivites.add(secteurActiviteDAO.findById(3)); //La candidature sera du secteur 3
    //Candidature nouvelleCand = new Candidature("Matthieu","Old", today, "44470", "@", "cv", today, qualificationDAO.findById(4), secteurActivites);
    //nouvelleCand = candidatureDAO.persist(nouvelleCand);
%>

<div class="row">
  <div class="col-lg-12">
    <div class="panel panel-default">
      <div class="panel-heading"><h3><i class="fa fa-th"></i> Ajouter votre candidature !!</h3></div> <!-- /.panel-heading -->
      <div class="panel-body">
        <div class="dataTable_wrapper">
        
		  <form>
		  <div class="form-group">
		    <label for="exampleInputEmail1">Prénom</label>
		    <input type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Prénom">
		  </div>
		  <div class="form-group">
		    <label for="exampleInputEmail1">Nom</label>
		    <input type="password" class="form-control" id="exampleInputPassword1" placeholder="Nom">
		  </div>
		  <div class="form-group">
		    <label for="exampleInputEmail1">Date de naissance</label>
		    <input type="password" class="form-control" id="exampleInputPassword1" placeholder="Date de naissance">
		  </div>
		  <div class="form-group">
		    <label for="exampleInputEmail1">Adresse postale</label>
		    <input type="password" class="form-control" id="exampleInputPassword1" placeholder="Adresse postale">
		  </div>
		  <div class="form-group">
		    <label for="exampleInputEmail1">Email</label>
		    <input type="password" class="form-control" id="exampleInputPassword1" placeholder="Email">
		  </div>
		  <div class="form-group">
		    <label for="exampleInputEmail1">CV</label>
		    <input type="password" class="form-control" id="exampleInputPassword1" placeholder="CV">
		  </div>
		
		  <button type="submit" class="btn btn-primary">Valider</button>
		</form>
        </div> <!-- /.table-responsive -->
      </div> <!-- /.panel-body -->
    </div> <!-- /.panel -->
  </div> <!-- /.col-lg-12 -->
</div> <!-- /.row -->
