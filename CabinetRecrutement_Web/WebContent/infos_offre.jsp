<%@ page language="java" contentType="text/html" pageEncoding="ISO-8859-1"%>

<%@page import="eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocator,
                eu.telecom_bretagne.cabinet_recrutement.front.utils.Utils,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceOffresEmplois,
                eu.telecom_bretagne.cabinet_recrutement.data.model.OffreEmploi,
                eu.telecom_bretagne.cabinet_recrutement.data.model.Qualification,
                eu.telecom_bretagne.cabinet_recrutement.data.model.SecteurActivite,
                java.util.Set,
                java.text.SimpleDateFormat"%>

<%
  String erreur = null;
  String idStringValue = request.getParameter("id");
  int id = -1;
  OffreEmploi offre = null;
  SimpleDateFormat formater = new SimpleDateFormat("dd/MM/yy");
  
  if(idStringValue == null)
  {
    erreur="Aucun identifiant d'offre d'emploi n'est fourni dans la demande.";
  }
  else
  {
    try
    {
      id = new Integer(idStringValue);
      // C'est OK : on a bien un id
      IServiceOffresEmplois serviceOffre = (IServiceOffresEmplois) ServicesLocator.getInstance().getRemoteInterface("ServiceOffresEmplois");
      offre = serviceOffre.getOffre(id);
      if(offre == null)
      {
        erreur="Aucune offre d'emploi ne correspond à cet identifiant : " + id;
      }
    }
    catch(NumberFormatException e)
    {
      erreur = "La valeur de l'identifiant n'est pas numérique";
    }
  }
%>

<div class="row">
  <div class="col-lg-12">
    <div class="panel panel-default">
      <div class="panel-heading"><h3><i class="fa fa-th"></i> Informations sur l'offre d'emploi</h3></div> <!-- /.panel-heading -->
      <div class="panel-body">
        <%
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
         </div> <!-- /.row col-xs-offset-1 col-xs-10 -->
         <%
         }
        else
        {
           %>
        <div class="table-responsive">
            <small>
            <table class="table">
              <tbody>
                <tr class="success">
                  <td width="200"><strong>Numéro de l'offre</strong></td>
                  <td><%=offre.getId()%></td>
                </tr>
                <tr class="warning">
                  <td><strong>Titre</strong></td>
                  <td><%=offre.getTitre()%></td>
                </tr>
                <tr class="warning">
                  <td><strong>Profil recherché</strong></td>
                  <td><%=offre.getProfilRecherche()%></td>
                </tr>
                <tr class="warning">
                  <td><strong>Qualification(s)</strong></td>
                  <td><ul><%
                 Set<Qualification> offrequal = offre.getQualifications();
                 for (Qualification q : offrequal)
                 {%>
                	 <li><%=q.getIntitule()%></li>
                 <%
                 }
                 %>
                 </ul></td>
                </tr>
                <tr class="warning">
                  <td><strong>Secteur(s)</strong></td>
                  <td><ul><%
                 Set<SecteurActivite> offreSecteur = offre.getSecteurActivites();
                 for (SecteurActivite q : offreSecteur)
                 {%>
                	 <li><%=q.getIntitule()%></li>
                 <%
                 }
                 %>
                 </ul></td>
                </tr>
                <tr class="warning">
                  <td><strong>Adresse postale (ville)</strong></td>
                  <td><%=offre.getEntreprise().getAdressePostale()%></td>
                </tr>
                <tr class="warning">
                  <td><strong>Descriptif de l'entreprise</strong></td>
                  <td><%=Utils.text2HTML(offre.getEntreprise().getDescriptif())%></td>
                </tr>
                <tr class="warning">
                  <td><strong>Descriptif de la mission</strong></td>
                  <td><%=Utils.text2HTML(offre.getDescriptif())%></td>
                </tr>
                <tr class="warning">
                  <td><strong>Date de dépôt</strong></td>
                  <td><%=formater.format(offre.getDateDepot())%></td>
                </tr>
              </tbody>
            </table>
            </small>      
        </div>
          <%
        }
        %>
      </div> <!-- /.panel-body -->
    </div> <!-- /.panel -->
  </div> <!-- /.col-lg-12 -->
</div> <!-- /.row -->
