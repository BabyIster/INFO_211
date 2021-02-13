package eu.telecom_bretagne.cabinet_recrutement.front.controlesDAO;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.util.Iterator;
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

    
    out.println("-------------------------------------------------------------------------------------------");

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
    
    out.println("Liste des secteur_activite :");
    List<SecteurActivite> secteurs = secteuractiviteDAO.findAll();
    
    for(SecteurActivite secteur : secteurs)
    {
      out.println(secteur.getId()+" : "+secteur.getIntitule());
    }
    out.println();
    
    out.println("Ajout du secteur Electronique/Microélectronique : ");
    SecteurActivite nouveauSecteur = new SecteurActivite("Electronique/Microélectronique");
    nouveauSecteur=secteuractiviteDAO.persist(nouveauSecteur);
    out.println(nouveauSecteur.getId()+" : "+nouveauSecteur.getIntitule());
    out.println();
    
    out.println("Modification en Agriculture : ");
    nouveauSecteur.setIntitule("Agriculture");
    nouveauSecteur=secteuractiviteDAO.update(nouveauSecteur);
    out.println(nouveauSecteur.getId()+" : "+nouveauSecteur.getIntitule());
    out.println();
    
    out.println("Supression du secteur Agriculture");
    secteuractiviteDAO.remove(nouveauSecteur);
    
    out.println("-------------------------------------------------------------------------------------------");
    
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
    
    out.println("Liste des entreprises :");
    List<Entreprise> entreprises = entrepriseDAO.findAll();
    
    for(Entreprise entreprise : entreprises)
    {
      out.println(entreprise.getId()+" : "+entreprise.getNom()+" à "+entreprise.getAdressePostale());
    }
    out.println();
    
    out.println("Ajout de l'entreprise AMD :");
    Entreprise AMD=new Entreprise("AMD", "Entreprise d'electronique","New York");
    entrepriseDAO.persist(AMD);
    out.println(AMD.getId()+" : "+AMD.getNom() +" | "+ AMD.getDescriptif());
    out.println();
    
    out.println("Modification du descriptif :");
    AMD.setDescriptif("Entreprise d'electronique spécialisé dans les processeurs");
    AMD=entrepriseDAO.update(AMD);
    out.println(AMD.getId()+" : "+AMD.getNom() +" | "+ AMD.getDescriptif());
    out.println();
    
    out.println("Supression de l'entreprise AMD (présent uniquement pour nos tests)");
    entrepriseDAO.remove(AMD);
    
    out.println("-------------------------------------------------------------------------------------------");
    
    try
    {
    	qualificationDAO = (QualificationDAO) ServicesLocator.getInstance().getRemoteInterface("QualificationDAO");
    }
    catch (ServicesLocatorException e)
    {
      e.printStackTrace();
    }
    out.println("Contrôles de fonctionnement du DAO QualificationDAO");
    out.println();
    
    out.println("Liste des qualifications :");
    List<Qualification> qualifications = qualificationDAO.findAll();
    
    for(Qualification qualification: qualifications)
    {
    	out.println(qualification.getId()+" : "+qualification.getIntitule());
    }
    out.println();
    
    out.println("Ajout de la qualification PDG :");
    Qualification PDG=new Qualification("PDG");
    qualificationDAO.persist(PDG);
    out.println(PDG.getId()+" : "+PDG.getIntitule());
    out.println();
    
    out.println("Modification de l'intitulé :");
    PDG.setIntitule("CEO");
    PDG=qualificationDAO.update(PDG);
    out.println(PDG.getId()+" : "+PDG.getIntitule());
    out.println();
    
    out.println("Supression de l'intitulé CEO (présent uniquement pour nos tests)");
    qualificationDAO.remove(PDG);
    
    out.println("-------------------------------------------------------------------------------------------");

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
    
    out.println("Liste des candidatures :");
    List<Candidature> candidatures = candidatureDAO.findAll();
    
    for(Candidature candidature : candidatures)
    {
      out.println(candidature.getId()+" : "+candidature.getNom() + " " + candidature.getPrenom());
    }
    out.println();
    
    out.println("La candidature n°3 correspond à :");
    out.println("Prenom : "+candidatureDAO.findById(3).getPrenom());
    out.println("Nom : "+candidatureDAO.findById(3).getNom());
    
    out.println();
    
    out.println("Ajout de la candidature de Matthieu (new Candidature(\"Matthieu\",\"Old\", dateC, \"44470\", \"@\", \"cv\", dateC, qualificationDAO.findById(4)))");
    Date dateC = new Date(1,1,1);
    Candidature nouvelleCand = new Candidature("Matthieu","Old", dateC, "44470", "@", "cv", dateC, qualificationDAO.findById(4));
    nouvelleCand = candidatureDAO.persist(nouvelleCand);
    
    out.println("Candidature ajoutée :");
    out.println(nouvelleCand.getId()+" : "+nouvelleCand.getPrenom() + " " + nouvelleCand.getNom());
    out.println();
    
    out.println("Modification de la candidature :");
    nouvelleCand.setNom("YOUNG");
    nouvelleCand=candidatureDAO.update(nouvelleCand);
    out.println(nouvelleCand.getId()+" : "+nouvelleCand.getPrenom() + " " + nouvelleCand.getNom());
    out.println();
    
    out.println("Suppression de la candidature");
    candidatureDAO.remove(nouvelleCand);
    
    out.println("Liste des candidatures :");
    candidatures = candidatureDAO.findAll();
    
    for(Candidature candidature : candidatures)
    {
      out.println(candidature.getId()+" : "+candidature.getNom() + " " + candidature.getPrenom());
    }
    out.println();
    
    out.println("-------------------------------------------------------------------------------------------");

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
    
    out.println("Liste des offres :");
    List<OffreEmploi> offres = offreEmploiDAO.findAll();
    
    for(OffreEmploi offreEmploi: offres)
    {
      out.print("Titre : " +offreEmploi.getTitre() + " | Description : ");
      out.print(offreEmploi.getDescriptif()+ " | proposé par l'entreprise n°");
      out.println(offreEmploi.getEntreprise().getId());
    }
    out.println();
    
    out.println("-------------------------------------------------------------------------------------------");
    
    out.println("Divers Contrôles de fonctionnement du DAO OffreEmploiDAO");
    out.println();
    
    out.println("Obtention des candidatures secteur 1 et qualification 3 :");
    List<Candidature> c = candidatureDAO.findBySectorAndQualification(1,3);
    for(Candidature candidature : c)
    {
      out.print("Nom : "+candidature.getNom());
      out.println(" | Prenom : " + candidature.getPrenom());
    }
    out.println();
    
  out.println();
  out.println("Obtention des offres d'emploi de l'entreprise 2");
  List<OffreEmploi> o = offreEmploiDAO.findByEntreprise(2);
  for(OffreEmploi offreEmploiEnt : o)
  {
	  out.print("Titre : "+offreEmploiEnt.getTitre() + " | Description : ");
	  out.println(offreEmploiEnt.getDescriptif());
  }
  out.println();  
  
  out.println("-------------------------------------------------------------------------------------------");
  
  }
}
