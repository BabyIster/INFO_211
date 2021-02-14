package eu.telecom_bretagne.cabinet_recrutement.front.controlesDAO;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

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
import eu.telecom_bretagne.cabinet_recrutement.data.dao.MessageCandidatureDAO;
import eu.telecom_bretagne.cabinet_recrutement.data.model.MessageCandidature;
import eu.telecom_bretagne.cabinet_recrutement.data.dao.MessageOffreEmploiDAO;
import eu.telecom_bretagne.cabinet_recrutement.data.model.MessageOffreEmploi;
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
    Secteur_activiteDAO secteurActiviteDAO = null;
    QualificationDAO qualificationDAO = null;
    MessageCandidatureDAO messageCandidatureDAO = null;
    MessageOffreEmploiDAO messageOffreEmploiDAO = null;

    
    out.println("-------------------------------------------------------------------------------------------");

    try
    {
    	secteurActiviteDAO = (Secteur_activiteDAO) ServicesLocator.getInstance().getRemoteInterface("Secteur_activiteDAO");
    }
    catch (ServicesLocatorException error)
    {
      error.printStackTrace();
    }
    out.println("Contrôles de fonctionnement du DAO Secteur_activiteDAO");
    out.println();
    
    out.println("Liste des secteur_activite :");
    List<SecteurActivite> secteurs = secteurActiviteDAO.findAll();
    
    for(SecteurActivite secteur : secteurs)
    {
      out.println(secteur.getId()+" : "+secteur.getIntitule());
    }
    out.println();
    
    out.println("Ajout du secteur Electronique/Microélectronique : ");
    SecteurActivite nouveauSecteur = new SecteurActivite("Electronique/Microélectronique");
    nouveauSecteur=secteurActiviteDAO.persist(nouveauSecteur);
    out.println(nouveauSecteur.getId()+" : "+nouveauSecteur.getIntitule());
    out.println();
    
    out.println("Modification en Agriculture : ");
    nouveauSecteur.setIntitule("Agriculture");
    nouveauSecteur=secteurActiviteDAO.update(nouveauSecteur);
    out.println(nouveauSecteur.getId()+" : "+nouveauSecteur.getIntitule());
    out.println();
    
    out.println("Supression du secteur Agriculture");
    secteurActiviteDAO.remove(nouveauSecteur);
    
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
      out.println("ENT_"+entreprise.getId()+" : "+entreprise.getNom()+" à "+entreprise.getAdressePostale() +" à envoyer " + entreprise.getOffreEmplois().size() +" offre(s)" );
    }
    out.println();
    
    out.println("Ajout de l'entreprise AMD :");
    Entreprise AMD=new Entreprise("AMD", "Entreprise d'electronique","New York");
    entrepriseDAO.persist(AMD);
    out.println("ENT_"+AMD.getId()+" : "+AMD.getNom() +" | "+ AMD.getDescriptif());
    out.println();
    
    out.println("Modification du descriptif :");
    AMD.setDescriptif("Entreprise d'electronique spécialisé dans les processeurs");
    AMD=entrepriseDAO.update(AMD);
    out.println("ENT_"+AMD.getId()+" : "+AMD.getNom() +" | "+ AMD.getDescriptif());
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
    
    out.println("Ajout de la candidature de Matthieu");
 
    @SuppressWarnings("deprecation")
	Date today = new Date(0,0,0);
    
    Set<SecteurActivite> secteurActivites = new HashSet<SecteurActivite>();
    secteurActivites.add(secteurActiviteDAO.findById(3)); //La candidature sera du secteur 3
    Candidature nouvelleCand = new Candidature("Matthieu","Old", today, "44470", "@", "cv", today, qualificationDAO.findById(4), secteurActivites);
    nouvelleCand = candidatureDAO.persist(nouvelleCand);
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
    
    List<OffreEmploi> offres = offreEmploiDAO.findAll();

    out.println("offre pour chaque enteprises ");
    out.println(" ");
    out.println(" *************************************************************** ");
    out.println(" ");

    for(Entreprise entreprise : entreprises)
    {
      out.println(entreprise.getId()+" : "+entreprise.getNom()+" à "+entreprise.getAdressePostale());
      
      out.println("Entreprise n° :" + entreprise.getId());

      for(OffreEmploi offreEmploi: offres) {

      	if(offreEmploi.getEntreprise().getId() == entreprise.getId()) {
      		 out.print("Titre : " +offreEmploi.getTitre() + " | Description : ");
      	      out.print(offreEmploi.getDescriptif());
      	}
       
      }
    }
    
    out.println(" ");
    out.println(" *************************************************************** ");

    
    out.println("Liste des offres :");
    
    for(OffreEmploi offreEmploi: offres)
    {
      out.print("N°"+offreEmploi.getId()+" Titre : " +offreEmploi.getTitre() + " | Description : ");
      out.print(offreEmploi.getDescriptif()+ " | proposé par l'entreprise n°");
      out.print(offreEmploi.getEntreprise().getId()+" | secteur(s) : ");
      Iterator iteratorSecteur = offreEmploi.getSecteurActivites().iterator();
      while (iteratorSecteur.hasNext()) {
    	  SecteurActivite secteur=(SecteurActivite) iteratorSecteur.next();
          out.print(secteur.getIntitule() + " ");
        }
      out.print(" | qualification(s) : ");
      Iterator iteratorQual = offreEmploi.getQualifications().iterator();
      while (iteratorQual.hasNext()) {
    	  Qualification qual=(Qualification) iteratorQual.next();
          out.print(qual.getIntitule() + " ");
        }
      out.println("\n");
    }
    out.println();
    
    out.println("Obtention des candidatures secteur 1 et qualification 3 :");
    List<Candidature> c = candidatureDAO.findBySectorAndQualification(1,3);
    for(Candidature candidature : c)
    {
      out.print("Nom : "+candidature.getNom());
      out.println(" | Prenom : " + candidature.getPrenom());
    }
    out.println();
    
  out.println("Obtention des offres d'emploi de l'entreprise 2");
  List<OffreEmploi> o = offreEmploiDAO.findByEntreprise(2);
  for(OffreEmploi offreEmploiEnt : o)
  {
	  out.print("Titre : "+offreEmploiEnt.getTitre() + " | Description : ");
	  out.println(offreEmploiEnt.getDescriptif());
  }
  out.println();  
  
  out.println("Création d'une offre d'emploi : ");
  OffreEmploi nouvelleOffre = new OffreEmploi("Stage de cuisine", "Nous recherchons un stagiaire pour nos cuisines", "Jeune dynamique", entrepriseDAO.findById(5), today, qualificationDAO.findById(2), secteurActivites);
  nouvelleOffre = offreEmploiDAO.persist(nouvelleOffre);
  out.print(nouvelleOffre.getId()+" : "+nouvelleOffre.getDescriptif() + " | " + nouvelleOffre.getProfilRecherche());
  out.println(" | proposé par l'entreprise n°"+nouvelleOffre.getEntreprise().getId());
  //il faudra s OCCUPER DE LA AJOUT DANS LES INDEX
  out.println();
  
  out.println("Modification de l'offre :");
  nouvelleOffre.setProfilRecherche("Jeune cuisinier dynamique a la recherche de la recette secrète");
  nouvelleOffre=offreEmploiDAO.update(nouvelleOffre);
  out.print(nouvelleOffre.getId()+" : "+nouvelleOffre.getDescriptif() + " | " + nouvelleOffre.getProfilRecherche());
  out.println(" | proposé par l'entreprise n°"+nouvelleOffre.getEntreprise().getId());
  out.println();
  
  out.println("Suppression de l'offre");
  offreEmploiDAO.remove(nouvelleOffre);
  
  out.println("-------------------------------------------------------------------------------------------");
  
  try
  {
	  messageCandidatureDAO = (MessageCandidatureDAO) ServicesLocator.getInstance().getRemoteInterface("MessageCandidatureDAO");
  }
  catch (ServicesLocatorException e)
  {
    e.printStackTrace();
  }
  out.println("Contrôles de fonctionnement du DAO MessageCandidatureDAO");
  out.println();
  
  out.println("Liste des messages candidats :");
  List<MessageCandidature> msgCands = messageCandidatureDAO.findAll();
  
  for(MessageCandidature msgCand: msgCands)
  {
    out.print("Messages : " +msgCand.getCorpsMessage() + " | Envoyé par : ");
    out.print(msgCand.getCandidature().getPrenom()+ " | Vers l'offre : ");
    out.println(msgCand.getOffreEmploi().getTitre()+" | Le : "+msgCand.getDateEnvoi());
  }
  out.println();
  
  out.println("Un candidat à envoyé un message :");
  MessageCandidature nouveauMsgCand = new MessageCandidature("Disponible Mercredi", today, candidatureDAO.findById(5), offreEmploiDAO.findById(4));
  nouveauMsgCand = messageCandidatureDAO.persist(nouveauMsgCand);
  out.print("Messages : " +nouveauMsgCand.getCorpsMessage() + " | Envoyé par : ");
  out.print(nouveauMsgCand.getCandidature().getPrenom()+ " | Vers l'offre : ");
  out.println(nouveauMsgCand.getOffreEmploi().getTitre()+" | Le : "+nouveauMsgCand.getDateEnvoi());
  out.println();
  
  out.println("Modification du message :");
  nouveauMsgCand.setCorpsMessage("Je suis disponible Mercredi");
  nouveauMsgCand = messageCandidatureDAO.update(nouveauMsgCand);
  out.print("Messages : " +nouveauMsgCand.getCorpsMessage() + " | Envoyé par : ");
  out.print(nouveauMsgCand.getCandidature().getPrenom()+ " | Vers l'offre : ");
  out.println(nouveauMsgCand.getOffreEmploi().getTitre()+" | Le : "+nouveauMsgCand.getDateEnvoi());
  out.println();
  
  out.println("Message(s) du candidat n°1 :");
  List<MessageCandidature> msgCand1 = messageCandidatureDAO.findByCandidature(1);
  for(MessageCandidature msgCand: msgCand1)
  {
    out.print("Messages : " +msgCand.getCorpsMessage() + " | Envoyé par : ");
    out.print(msgCand.getCandidature().getPrenom()+ " | Vers l'offre : ");
    out.println(msgCand.getOffreEmploi().getTitre()+" | Le : "+msgCand.getDateEnvoi());
  }
  out.println();
  
  out.println("Message(s) envoyé à l'offre n°2 :");
  List<MessageCandidature> msgOffre2 = messageCandidatureDAO.findByOffre(2);
  for(MessageCandidature msgCand: msgOffre2)
  {
    out.print("Messages : " +msgCand.getCorpsMessage() + " | Envoyé par : ");
    out.print(msgCand.getCandidature().getPrenom()+ " | Vers l'offre : ");
    out.println(msgCand.getOffreEmploi().getTitre()+" | Le : "+msgCand.getDateEnvoi());
  }
  out.println();
  
  out.println("Suppression du message");
  messageCandidatureDAO.remove(nouveauMsgCand);
  
out.println("-------------------------------------------------------------------------------------------");
  
  try
  {
	  messageOffreEmploiDAO = (MessageOffreEmploiDAO) ServicesLocator.getInstance().getRemoteInterface("MessageOffreEmploiDAO");
  }
  catch (ServicesLocatorException e)
  {
    e.printStackTrace();
  }
  out.println("Contrôles de fonctionnement du DAO MessageOffreEmploiDAO");
  out.println();
  
  out.println("Liste des messages candidats :");
  List<MessageOffreEmploi> msgOffres = messageOffreEmploiDAO.findAll();
  
  for(MessageOffreEmploi msgOffre: msgOffres)
  {
    out.print("Messages : " +msgOffre.getCorpsMessage() + " | Envoyé par : ");
    out.print(msgOffre.getCandidature().getPrenom()+ " | Vers l'offre : ");
    out.println(msgOffre.getOffreEmploi().getTitre()+" | Le : "+msgOffre.getDateEnvoi());
  }
  out.println();
  
  out.println("Une entreprise à envoyé un message via une offre :");
  MessageOffreEmploi nouveauMsgOffre = new MessageOffreEmploi("L'avez-vous reçu ?", today, offreEmploiDAO.findById(2), candidatureDAO.findById(2));
  nouveauMsgOffre = messageOffreEmploiDAO.persist(nouveauMsgOffre);
  out.print("Messages : " +nouveauMsgOffre.getCorpsMessage() + " | Envoyé par : ");
  out.print(nouveauMsgOffre.getOffreEmploi().getTitre()+ " | Vers l'offre : ");
  out.println(nouveauMsgOffre.getCandidature().getPrenom()+" | Le : "+nouveauMsgOffre.getDateEnvoi());
  out.println();
  
  out.println("Modification du message :");
  nouveauMsgOffre.setCorpsMessage("Avez-vous bien reçu le mail de convocation");
  nouveauMsgOffre = messageOffreEmploiDAO.update(nouveauMsgOffre);
  out.print("Messages : " +nouveauMsgOffre.getCorpsMessage() + " | Envoyé par : ");
  out.print(nouveauMsgOffre.getOffreEmploi().getTitre()+ " | Vers l'offre : ");
  out.println(nouveauMsgOffre.getCandidature().getPrenom()+" | Le : "+nouveauMsgOffre.getDateEnvoi());
  out.println();
  
  out.println("Message(s) de l'offre n°1 :");
  List<MessageOffreEmploi> msgOffre1 = messageOffreEmploiDAO.findByOffre(1);
  for(MessageOffreEmploi msgOffre: msgOffre1)
  {
    out.print("Messages : " +msgOffre.getCorpsMessage() + " | Envoyé à : ");
    out.print(msgOffre.getCandidature().getPrenom()+ " | Via l'offre : ");
    out.println(msgOffre.getOffreEmploi().getTitre()+" | Le : "+msgOffre.getDateEnvoi());
  }
  out.println();
  
  out.println("Message(s) envoyé à la candidature n°2 :");
  List<MessageOffreEmploi> msgCand2 = messageOffreEmploiDAO.findByOffre(2);
  for(MessageOffreEmploi msgCand: msgCand2)
  {
    out.print("Messages : " +msgCand.getCorpsMessage() + " | Envoyé à : ");
    out.print(msgCand.getCandidature().getPrenom()+ " | Via l'offre : ");
    out.println(msgCand.getOffreEmploi().getTitre()+" | Le : "+msgCand.getDateEnvoi());
  }
  out.println();
  
  out.println("Suppression du message");
  messageOffreEmploiDAO.remove(nouveauMsgOffre);
  }
}
