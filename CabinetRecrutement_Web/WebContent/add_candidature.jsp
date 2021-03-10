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
                java.util.List,
                java.util.HashSet,
                java.text.SimpleDateFormat,
                java.text.DateFormat"%>
                
<%
IServiceCandidature servicecandidature = (IServiceCandidature) ServicesLocator.getInstance().getRemoteInterface("ServiceCandidature");
IServiceSecteurActivite serviceSecteurActivite = (IServiceSecteurActivite) ServicesLocator.getInstance().getRemoteInterface("ServiceSecteurActivite");
IServiceQualification serviceQualification = (IServiceQualification) ServicesLocator.getInstance().getRemoteInterface("ServiceQualification");

List<SecteurActivite> allsecteurs = serviceSecteurActivite.listeDesSecteurActivites();
List<Qualification> allqualifications = serviceQualification.listeDesQualifications();

SimpleDateFormat formater = new SimpleDateFormat("dd-MM-yyyy");
SimpleDateFormat formater2 = new SimpleDateFormat("yyyy-MM-dd");

String erreur = null;
String prenom = request.getParameter("InputPrenom");
String nom = request.getParameter("InputNom");
String ville = request.getParameter("InputAdresse");
String dateNaissance = request.getParameter("InputDate");
String mail = request.getParameter("InputMail");
String cv = request.getParameter("InputCV");

String qualInput = request.getParameter("InputQualification");
String[] secteurInput = request.getParameterValues("InputSecteur");

Set<SecteurActivite> secteurs = new HashSet<SecteurActivite>();
int idSec=1;

if(request.getParameter("InputSecteur")!=null){
		for(String sec : secteurInput){
			try{
				idSec=Integer.parseInt(sec);
			}catch(Exception e){
				erreur = "Probléme sur les secteurs !";
			}
			secteurs.add(serviceSecteurActivite.getSecteurActivite(idSec));
		}
}

%>
<div class="row">
  <div class="col-lg-12">
    <div class="panel panel-default">
      <div class="panel-heading"><h3><i class="fa fa-th"></i> Ajouter votre candidature</h3></div> <!-- /.panel-heading -->
      <div class="panel-body">
        <div class="dataTable_wrapper">
        <%
	if(prenom==null & nom==null & ville==null & dateNaissance==null & mail==null & cv==null & qualInput==null & secteurInput==null){
		%>        
		  <form action="template.jsp?action=add_candidature" method="post">
		  <div class="form-group">
		    <label for="InputPrenom">Prenom</label>
		    <input type="text" class="form-control" name="InputPrenom" aria-describedby="emailHelp" placeholder="Prénom" required>
		  </div>
		 <div class="form-group">
		    <label for="InputNom">Nom</label>
		    <input type="text" class="form-control" name="InputNom" aria-describedby="emailHelp" placeholder="Nom" required>
		  </div>
		  <div class="form-group">
		    <label for="Inputdate">Date de naissance (dd/MM/yyyy)</label>
		    <input type="date" class="form-control" name="InputDate" placeholder="Date de naissance" required>
		  </div>
		  <div class="form-group">
		    <label for="Inputadresse">Adresse postale</label>
		    <input type="text" class="form-control" name="InputAdresse" placeholder="Adresse postale" required>
		  </div>
		  <div class="form-group">
		    <label for="Inputmail">Email</label>
		    <input type="email" class="form-control" name="InputMail" placeholder="Email" required>
		  </div>
		  <div class="form-group">
		    <label for="InputCV">CV</label>
		    <textarea class="form-control" name="InputCV" placeholder="Detailler votre cv" rows="3" name="cv" required></textarea>
		  </div>
		  
		   <div class="form-group">
			  <label for="InputSecteur">Secteur activité:</label>	
			    <%			  
			     for (SecteurActivite q : allsecteurs) {%>
                	 <INPUT type="checkbox" name="InputSecteur" value="<%=q.getId()%>"> <%=q.getIntitule() %>
                 <%
                 }%>
			</div>
			
			<div class="form-group">
			  <label for="InputQualification">Qualification:</label>
			  <select class="form-control" id="InputQualification" name= "InputQualification">
			    <%			  
			    for (Qualification k : allqualifications)
                {%>
               	 <option name="InputQualification" value="<%=k.getId()%>"><%=k.getIntitule() %></option>
                <%
                }%>
               </select>			 
			</div>
		  <button type="submit" class="btn btn-primary">Valider</button>
		</form>
<%
	}
	else if(prenom.isEmpty() | nom.isEmpty() | ville.isEmpty() | secteurs.isEmpty() | dateNaissance.isEmpty() | mail.isEmpty() | cv.isEmpty()){
		erreur = "Aucun des paramétres ne doit être nul, pensez a bien coché un secteur";
	}
	else{
		Date date = new Date();
	    int idQual = 1;
	    
	    try{
	    	  idQual=Integer.parseInt(qualInput);
	      }
	      catch(Exception e){
	    	  erreur ="Erreur sur la qualification, l'id ("+qualInput+") est mauvais";
	      }
	    if(erreur==null){
		      Qualification qualification = serviceQualification.getQualification(idQual);
		      
		      Date dateNaissanceFormat = formater2.parse(dateNaissance);
		      
		      Candidature candidature = new Candidature(prenom, nom, dateNaissanceFormat, ville, mail, cv, date, qualification, secteurs);
		      candidature = servicecandidature.CreationCandidature(candidature);
		      
		      %>
		      	<p>Page création</p>
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
		                  <td><%
		                 Set <SecteurActivite> secteursList = candidature.getSecteurActivites();
		                 for (SecteurActivite s : secteursList)
		                 {%>
		                	 <li><%=s.getIntitule()%></li>
		                 <%
		                 }
		                 %></td>
		                </tr>
		              </tbody>
		            </table>
		            </small>
		            <br><b><a href="template.jsp">Retour a l'accueil</a></b>       
		        </div>
		          <%
		        }
	}if(erreur != null) // Une erreur a été détectée et est affichée.
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
       }%>
        </div> <!-- /.table-responsive -->
      </div> <!-- /.panel-body -->
    </div> <!-- /.panel -->
  </div> <!-- /.col-lg-12 -->
</div> <!-- /.row -->
