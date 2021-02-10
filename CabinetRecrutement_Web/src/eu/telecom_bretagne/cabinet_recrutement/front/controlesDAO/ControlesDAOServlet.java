package eu.telecom_bretagne.cabinet_recrutement.front.controlesDAO;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import eu.telecom_bretagne.cabinet_recrutement.data.dao.EntrepriseDAO;
import eu.telecom_bretagne.cabinet_recrutement.data.model.Entreprise;
import eu.telecom_bretagne.cabinet_recrutement.data.dao.CandidatureDAO;
import eu.telecom_bretagne.cabinet_recrutement.data.model.Candidature;
import eu.telecom_bretagne.cabinet_recrutement.data.dao.OffreEmploiDAO;
import eu.telecom_bretagne.cabinet_recrutement.data.model.OffreEmploi;
import eu.telecom_bretagne.cabinet_recrutement.data.dao.Secteur_activiteDAO;
import eu.telecom_bretagne.cabinet_recrutement.data.model.SecteurActivite;
import eu.telecom_bretagne.cabinet_recrutement.data.dao.QualificationDAO;
import eu.telecom_bretagne.cabinet_recrutement.data.model.Qualification;
import eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocator;
import eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocatorException;

/**
 * Servlet implementation class TestServlet
 */
@WebServlet("/ControlesDAO")
public class ControlesDAOServlet extends HttpServlet
{
  //-----------------------------------------------------------------------------
  private static final long serialVersionUID = 1L;
  //-----------------------------------------------------------------------------
  /**
   * @see HttpServlet#HttpServlet()
   */
  public ControlesDAOServlet()
  {
    super();
  }
  //-----------------------------------------------------------------------------
  /**
   * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
   */
  protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
  {
    // Flot de sortie pour écriture des résultats.
    PrintWriter out = response.getWriter();
    
    // Récupération de la réféence vers le(s) DAO(s)
    EntrepriseDAO entrepriseDAO = null;
    CandidatureDAO candidatureDAO = null;
    OffreEmploiDAO offreEmploiDAO = null;
    Secteur_activiteDAO secteuractiviteDAO = null;
    QualificationDAO qualificationDAO = null;

    try
    {
      entrepriseDAO = (EntrepriseDAO) ServicesLocator.getInstance().getRemoteInterface("EntrepriseDAO");
    }
    catch (ServicesLocatorException e)
    {
      e.printStackTrace();
    }
    out.println("Contrôles de fonctionnement du DAO EntrepriseDAO");
    out.println();
    
    // ---------------------------------------------------------------------------------------------------------------

    
    try
    {
      candidatureDAO = (CandidatureDAO) ServicesLocator.getInstance().getRemoteInterface("CandidatureDAO");
    }
    catch (ServicesLocatorException e)
    {
      e.printStackTrace();
    }
    out.println("Contrôles de fonctionnement du DAO CandidatureDAO");
    out.println();
    
// ---------------------------------------------------------------------------------------------------------------
    
    try
    {
      offreEmploiDAO = (OffreEmploiDAO) ServicesLocator.getInstance().getRemoteInterface("OffreEmploiDAO");
    }
    catch (ServicesLocatorException e)
    {
      e.printStackTrace();
    }
    out.println("Contrôles de fonctionnement du DAO OffreEmploiDAO");
    out.println();
    
// ---------------------------------------------------------------------------------------------------------------
    
    try
    {
    	secteuractiviteDAO = (Secteur_activiteDAO) ServicesLocator.getInstance().getRemoteInterface("Secteur_activiteDAO");
    }
    catch (ServicesLocatorException error)
    {
      error.printStackTrace();
    }
    out.println("Contrôles de fonctionnement du DAO Secteur_activiteDAO");
    out.println();
    
// ---------------------------------------------------------------------------------------------------------------
    
    try
    {
    	qualificationDAO = (QualificationDAO) ServicesLocator.getInstance().getRemoteInterface("QualificationDAO");
    }
    catch (ServicesLocatorException error)
    {
      error.printStackTrace();
    }
    out.println("Contrôles de fonctionnement du DAO QualificationDAO");
    out.println();
    
    // Contrôle(s) de fonctionnalités.
    
    out.println("Liste des entreprises :");
    List<Entreprise> entreprises = entrepriseDAO.findAll();
    
    for(Entreprise entreprise : entreprises)
    {
      out.println(entreprise.getNom());
    }
    out.println();
    
    out.println("Liste des candidatures :");
    List<Candidature> candidatures = candidatureDAO.findAll();
    
    for(Candidature candidature : candidatures)
    {
      out.print(candidature.getNom());
      out.println(candidature.getPrenom());
    }
    out.println();
    
    out.println("Liste des offres :");
    List<OffreEmploi> offres = offreEmploiDAO.findAll();
    
    for(OffreEmploi offreEmploi: offres)
    {
      out.print(offreEmploi.getTitre());
      out.println(offreEmploi.getDescriptif());
    }
    out.println();
    
    out.println("Obtention de l'entreprise n° 1 :");
    Entreprise e = entrepriseDAO.findById(1);
    out.println(e.getId());
    out.println(e.getNom());
    out.println(e.getDescriptif());
    out.println(e.getAdressePostale());
    out.println();

    out.println("Obtention de l'entreprise n° 2 :");
    e = entrepriseDAO.findById(2);
    out.println(e.getId());
    out.println(e.getNom());
    out.println(e.getDescriptif());
    out.println(e.getAdressePostale());
    out.println();
    
    out.println("Obtention des candidatures secteur 1 et qualification 1 :");
    List<Candidature> c = candidatureDAO.findBySectorAndQualification(1,1);
    for(Candidature candidature : c)
    {
      out.print("Nom : "+candidature.getNom() + " ");
      out.println("Prenom : " + candidature.getPrenom());
    }
    out.println();
    
  out.println();
  out.println("Obtention des offres d'emploi de l'entreprise 2");
  List<OffreEmploi> o = offreEmploiDAO.findByEntreprise(2);
  for(OffreEmploi offreEmploiEnt : o)
  {
	  out.print(offreEmploiEnt.getTitre() + " Desc : ");
	  out.println(offreEmploiEnt.getDescriptif());
  }
  out.println();
  
    
    // ---------------------------------------------------------------------------------------------------------------
    
    out.println("Liste des secteur_activite :");
    List<SecteurActivite> secteurs = secteuractiviteDAO.findAll();
    
    for(SecteurActivite secteur : secteurs)
    {
      out.println(secteur.getIntitule());
    }
    out.println();
    
    out.println("Liste des qualifications :");
    List<Qualification> qualifications = qualificationDAO.findAll();
    
    for(Qualification qualification : qualifications)
    {
      out.println(qualification.getIntitule());
    }
    out.println();
    
    out.println("Listes des offre d'emplois par secteur d'activité :");
    
    for(SecteurActivite secteur : secteurs) {
    	out.println("Offre pour : " + secteur.getIntitule());
    	for(int i = 0; i < secteurs.size(); i ++) {
        	if(offres.get(i).getSecteurActivites() == secteur) {
        		out.println(" - " + offres.get(i).getTitre());
        	}
        }
    }
    out.println();
    
    
  out.println("Obtention des offres secteur 1 et qualification 1 :");
  o = offreEmploiDAO.findBySectorAndQualification(1,1);
  for(OffreEmploi offreEmploiSecQual : o)
  {
	  out.print(offreEmploiSecQual.getTitre() + " Desc : ");
      out.println(offreEmploiSecQual.getDescriptif());
  }
  out.println();
  
}

  //-----------------------------------------------------------------------------
}
