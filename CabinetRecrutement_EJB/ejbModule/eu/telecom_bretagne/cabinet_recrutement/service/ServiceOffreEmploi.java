package eu.telecom_bretagne.cabinet_recrutement.service;

import java.util.List;

import javax.ejb.EJB;
import javax.ejb.LocalBean;
import javax.ejb.Stateless;

import eu.telecom_bretagne.cabinet_recrutement.data.dao.OffreEmploiDAO;
import eu.telecom_bretagne.cabinet_recrutement.data.dao.Secteur_activiteDAO;
import eu.telecom_bretagne.cabinet_recrutement.data.dao.EntrepriseDAO;
import eu.telecom_bretagne.cabinet_recrutement.data.dao.CandidatureDAO;
import eu.telecom_bretagne.cabinet_recrutement.data.dao.MessageCandidatureDAO;
import eu.telecom_bretagne.cabinet_recrutement.data.dao.MessageOffreEmploiDAO;
import eu.telecom_bretagne.cabinet_recrutement.data.model.MessageCandidature;
import eu.telecom_bretagne.cabinet_recrutement.data.model.MessageOffreEmploi;
import eu.telecom_bretagne.cabinet_recrutement.data.model.OffreEmploi;
import eu.telecom_bretagne.cabinet_recrutement.data.model.Qualification;
import eu.telecom_bretagne.cabinet_recrutement.data.model.SecteurActivite;
import java.util.Set;

/**
 * Session Bean implementation class ServiceOffresEmplois
 * @author Florian GUILLOT
 */
@Stateless
@LocalBean
public class ServiceOffreEmploi implements IServiceOffreEmploi{
	//-----------------------------------------------------------------------------
	@EJB private OffreEmploiDAO         offreEmploiDAO;
	@EJB private Secteur_activiteDAO         secteurDAO;
	@EJB private EntrepriseDAO         entrepriseDAO;
    @EJB private MessageOffreEmploiDAO         messageOffreDAO;
    @EJB private MessageCandidatureDAO         messageCandidatureDAO;
    @EJB private CandidatureDAO         candidatureDAO;
	//-----------------------------------------------------------------------------
    /**
     * Default constructor. 
     */
    public ServiceOffreEmploi() {
        // TODO Auto-generated constructor stub
    }
    
    @Override
    public List<OffreEmploi> listeDesOffres()
    {
      return offreEmploiDAO.findAll();
    }
    //-----------------------------------------------------------------------------
    @Override
    public OffreEmploi getOffre(int id)
    {
      return offreEmploiDAO.findById(id);
    }
  //-----------------------------------------------------------------------------
    @Override
    public OffreEmploi CreationOffre(OffreEmploi offreEmploi)
    {
      OffreEmploi offreReturn = offreEmploiDAO.persist(offreEmploi);
      Set<SecteurActivite> secteurs = offreReturn.getSecteurActivites();
      
      offreReturn.getEntreprise().addOffreEmploi(offreReturn);
      entrepriseDAO.update(offreReturn.getEntreprise());
      
      for(SecteurActivite s : secteurs) {
    	  s.addOffreEmplois(offreReturn);
    	  //secteurDAO.update(s);
      }
      return offreReturn;
    }
    //-----------------------------------------------------------------------------
    @Override
    public OffreEmploi UpdateOffre(OffreEmploi offre)
    {
      return offreEmploiDAO.update(offre);
    }
  //-----------------------------------------------------------------------------
    @Override
    public void RemoveOffre(OffreEmploi offre)
    {
    	Set<MessageOffreEmploi> messages = offre.getMessageOffreEmplois();
    	
    	for(MessageOffreEmploi m : messages) {
	    	offre.getMessageOffreEmplois().remove(m);
	    	//m.getCandidature().getMessageOffreEmplois().remove(m);
	    	//candidatureDAO.update(m.getCandidature());
	    	messageOffreDAO.remove(m);
	    }
	    /*for(MessageCandidature m : offre.getMessageCandidatures()) {
	    	offre.getMessageCandidatures().remove(m);
	    	offreEmploiDAO.update(offre);
	    	m.getCandidature().removeMessageCandidature(m);
	    	candidatureDAO.update(m.getCandidature());
	    	messageCandidatureDAO.remove(m);
	    }
	    for (SecteurActivite s : offre.getSecteurActivites()) {
	    	offre.getSecteurActivites().remove(s);
	    	offre = offreEmploiDAO.update(offre);
	    	s.getOffreEmplois().remove(offre);
	    	secteurDAO.update(s);
	    }*/
      offre = offreEmploiDAO.update(offre);
	  offre.getEntreprise().getOffreEmplois().remove(offre);
	  entrepriseDAO.update(offre.getEntreprise());
      offreEmploiDAO.remove(offre);
    }
  //-----------------------------------------------------------------------------

	@Override
	public List<OffreEmploi> listOffreQualification(Qualification qualification) {
		List<OffreEmploi> toreturn = listeDesOffres();
		
		for(OffreEmploi offre : toreturn) {
			if(!offre.getQualifications().getIntitule().equalsIgnoreCase(qualification.getIntitule())) {
				toreturn.remove(offre);
			}
		}
		
		return toreturn;
	}
}
