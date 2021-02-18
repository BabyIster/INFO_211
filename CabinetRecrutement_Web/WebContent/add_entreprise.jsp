<%@ page language="java" contentType="text/html" pageEncoding="ISO-8859-1"%>

<%@page import="eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocator,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceEntreprise,
                eu.telecom_bretagne.cabinet_recrutement.data.model.Entreprise,
                java.util.List"%>

<%
IServiceEntreprise serviceCandidature = (IServiceEntreprise) ServicesLocator.getInstance().getRemoteInterface("ServiceEntreprise");
%>

<div class="row">
  <div class="col-lg-12">
    <div class="panel panel-default">
      <div class="panel-heading"><h3><i class="fa fa-th"></i> Ajouter une entreprise</h3></div> <!-- /.panel-heading -->
      <div class="panel-body">
        <div class="dataTable_wrapper">
        
		  <form action="add_entreprise_persist.jsp">
		  <div class="form-group">
		    <label for="InputNomEntreprise">Nom</label>
		    <input type="text" class="form-control" name="InputNomEntreprise" aria-describedby="emailHelp" placeholder="Nom de l'entreprise">
		  </div>
		  <div class="form-group">
		    <label for="InputDescEntreprise">Descriptif</label>
		    <textarea class="form-control" placeholder="Descriptif de l'entreprise" rows="3" name="InputDescEntreprise"></textarea>
		  </div>
		  <div class="form-group">
		    <label for="InputAdresseEntreprise">Adresse postale (Ville)</label>
		    <input type="text" class="form-control" name="InputAdresseEntreprise" placeholder="Ville de l'entreprise">
		  </div>
		
		  <button type="submit" class="btn btn-primary">Valider</button>
		</form>
        </div> <!-- /.table-responsive -->
      </div> <!-- /.panel-body -->
    </div> <!-- /.panel -->
  </div> <!-- /.col-lg-12 -->
</div> <!-- /.row -->
