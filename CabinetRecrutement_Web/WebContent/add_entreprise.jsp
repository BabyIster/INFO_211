<%@ page language="java" contentType="text/html" pageEncoding="ISO-8859-1"%>

<%@page import="eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocator,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceEntreprise,
                eu.telecom_bretagne.cabinet_recrutement.front.utils.Utils,
                eu.telecom_bretagne.cabinet_recrutement.data.model.Entreprise,
                java.util.List"%>

<%
IServiceEntreprise serviceEntreprise = (IServiceEntreprise) ServicesLocator.getInstance().getRemoteInterface("ServiceEntreprise");

String erreur = null;
String nom = request.getParameter("InputNomEntreprise");
String desc = request.getParameter("InputDescEntreprise");
String ville = request.getParameter("InputAdresseEntreprise");



%>
<div class="row">
  <div class="col-lg-12">
    <div class="panel panel-default">
      <div class="panel-heading"><h3><i class="fa fa-th"></i> Création entreprise</h3></div> <!-- /.panel-heading -->
      <div class="panel-body">
        <%

if(nom==null & desc==null & ville==null){
	%>
	<form action="template.jsp?action=add_entreprise" method="post">
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
	<%
}
else if(nom.isEmpty() | desc.isEmpty() | ville.isEmpty()){
	erreur = "Aucun des paramétres ne doit être nul";
}
/*else if(ville.matches("[A-Za-z0-9]+")){
    erreur = "On ne met pas de chiffre dans le nom d'une ville !";
    }*/
else{
	
	  Entreprise entreprise = new Entreprise(nom, desc, ville);
	  entreprise = serviceEntreprise.CreationEntreprise(entreprise);
	  
	  %>
      <div class="table-responsive">
          <small>
          <table class="table">
            <tbody>
              <tr class="success">
                <td width="200"><strong>Identifiant (login)</strong></td>
                <td>ENT_<%=entreprise.getId()%></td>
              </tr>
              <tr class="warning">
                <td><strong>Nom</strong></td>
                <td><%=entreprise.getNom()%></td>
              </tr>
              <tr class="warning">
                <td><strong>Adresse postale (ville)</strong></td>
                <td><%=entreprise.getAdressePostale()%></td>
              </tr>
              <tr class="warning">
                <td><strong>Descriptif</strong></td>
                <td><%=Utils.text2HTML(entreprise.getDescriptif())%></td>
              </tr>
            </tbody>
          </table>
          </small>      
      </div>
        <%
} if(erreur != null) // Une erreur a été détectée et est affichée.
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
           <br><b><a href="template.jsp?action=add_entreprise">Retour a la page de création</a></b>
         </div> <!-- /.row col-xs-offset-1 col-xs-10 -->
         <%
         }%>		
        </div> <!-- /.table-responsive -->
      </div> <!-- /.panel-body -->
    </div> <!-- /.panel -->
  </div> <!-- /.col-lg-12 -->
</div> <!-- /.row -->
