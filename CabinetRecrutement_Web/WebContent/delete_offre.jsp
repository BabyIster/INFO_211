<%@ page language="java" contentType="text/html" pageEncoding="ISO-8859-1"%>

<%@page import="eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocator,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceEntreprise,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceOffreEmploi,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceMessageOffre,
                eu.telecom_bretagne.cabinet_recrutement.data.model.Entreprise,
                eu.telecom_bretagne.cabinet_recrutement.data.model.OffreEmploi,
                eu.telecom_bretagne.cabinet_recrutement.data.model.MessageOffreEmploi,
                java.util.List,
				java.util.Set"%>
                
<%
IServiceEntreprise serviceEntreprise = (IServiceEntreprise) ServicesLocator.getInstance().getRemoteInterface("ServiceEntreprise");
IServiceOffreEmploi serviceOffreEmploi = (IServiceOffreEmploi) ServicesLocator.getInstance().getRemoteInterface("ServiceOffreEmploi");

Object utilisateur = session.getAttribute("utilisateur");

String id = request.getParameter("id");
String erreur=null;

if(utilisateur instanceof Entreprise)
{
	Entreprise entreprise = (Entreprise) utilisateur;

	if(id==null){
		erreur = "L'identifiant de l'offre a supprimer est nul";
	}
	else if(!id.matches("-?\\d+(\\.\\d+)?")){
		erreur = "L'identifiant doit-être un chiffre !";
	}
	/*else if(Integer.parseInt(id)!=entreprise.getId()){
		erreur = "Vous ne pouvez supprimer que vos offres !";
	}*/
	else{
		OffreEmploi offre = serviceOffreEmploi.getOffre(Integer.parseInt(id));
		%>
		<div class="col-lg-4">
        <div class="panel panel-danger">
            <div class="panel-heading">
                Offre supprimée
            </div>
            <div class="panel-body">
                <p>L'offre <%=offre.getTitre() %> n'est désormait plus dans notre base de données</p>
                <b><a href="template.jsp">Retour à l'accueil</a></b>
            </div>
        </div>
    </div>
    <%
	serviceOffreEmploi.RemoveOffre(offre);
	}
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
	   <br><b><a href="template.jsp">Retour a l'accueil</a></b>
	 </div> <!-- /.row col-xs-offset-1 col-xs-10 -->
	 <%
	 }
}
else{
	%>
	 <div class="row col-xs-offset-1 col-xs-10">
	   <div class="panel panel-red">
	     <div class="panel-heading ">
	       Impossible de traiter la demande
	     </div>
	     <div class="panel-body text-center">
	       <p class="text-danger"><strong>Vous n'êtes pas autorisé à supprimé des offres !</strong></p>
	       <p class="text-danger">Connectez-vous avec votre compte entreprise pour pouvoir supprimer les votres</p>
	     </div>
	   </div>
	   <br><b><a href="template.jsp">Retour a l'accueil</a></b>
	 </div> <!-- /.row col-xs-offset-1 col-xs-10 -->
	 <%

}%>
 
 </div> <!-- /.table-responsive -->
		      </div> <!-- /.panel-body -->
		    </div> <!-- /.panel -->
		  </div> <!-- /.col-lg-12 -->
		</div> <!-- /.row -->