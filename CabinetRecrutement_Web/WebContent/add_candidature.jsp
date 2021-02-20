<%@ page language="java" contentType="text/html" pageEncoding="ISO-8859-1"%>

<div class="row">
  <div class="col-lg-12">
    <div class="panel panel-default">
      <div class="panel-heading"><h3><i class="fa fa-th"></i> Ajouter votre candidature</h3></div> <!-- /.panel-heading -->
      <div class="panel-body">
        <div class="dataTable_wrapper">
        
		  <form action="template.jsp?action=add_candidature_persist" method="post">
		  <div class="form-group">
		    <label for="prenom">Prénom</label>
		    <input type="text" class="form-control" id="prenom" aria-describedby="emailHelp" placeholder="Prénom">
		  </div>
		  <div class="form-group">
		    <label for="nom">Nom</label>
		    <input type="text" class="form-control" id="nom" placeholder="Nom">
		  </div>
		  <div class="form-group">
		    <label for="date">Date de naissance (dd/MM/yyyy)</label>
		    <input type="text" class="form-control" id="date" placeholder="Date de naissance">
		  </div>
		  <div class="form-group">
		    <label for="adresse">Adresse postale</label>
		    <input type="text" class="form-control" id="adresse" placeholder="Adresse postale">
		  </div>
		  <div class="form-group">
		    <label for="mail">Email</label>
		    <input type="email" class="form-control" id="mail" placeholder="Email">
		  </div>
		  <div class="form-group">
		    <label for="cv">CV</label>
		    <textarea class="form-control" placeholder="Detailler votre cv" rows="3" name="cv"></textarea>
		  </div>
		
		  <button type="submit" class="btn btn-primary">Valider</button>
		</form>
        </div> <!-- /.table-responsive -->
      </div> <!-- /.panel-body -->
    </div> <!-- /.panel -->
  </div> <!-- /.col-lg-12 -->
</div> <!-- /.row -->
