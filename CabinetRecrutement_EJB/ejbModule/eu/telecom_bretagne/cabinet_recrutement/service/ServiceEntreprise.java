package eu.telecom_bretagne.cabinet_recrutement.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import javax.ejb.EJB;
import javax.ejb.LocalBean;
import javax.ejb.Stateless;
import javax.jws.WebService;

import eu.telecom_bretagne.cabinet_recrutement.data.dao.EntrepriseDAO;
import eu.telecom_bretagne.cabinet_recrutement.data.dao.OffreEmploiDAO;
import eu.telecom_bretagne.cabinet_recrutement.data.dao.MessageOffreEmploiDAO;
import eu.telecom_bretagne.cabinet_recrutement.data.dao.MessageCandidatureDAO;
import eu.telecom_bretagne.cabinet_recrutement.data.model.Entreprise;
import eu.telecom_bretagne.cabinet_recrutement.data.model.MessageCandidature;
import eu.telecom_bretagne.cabinet_recrutement.data.model.MessageOffreEmploi;
import eu.telecom_bretagne.cabinet_recrutement.data.model.OffreEmploi;

/**
 * Session Bean implementation class ServiceEntreprise
 * @author Philippe TANGUY
 */
@Stateless
@LocalBean
public class ServiceEntreprise implements IServiceEntreprise
{
  //-----------------------------------------------------------------------------
  @EJB private EntrepriseDAO         entrepriseDAO;
  @EJB private OffreEmploiDAO         offreDAO;
  @EJB private MessageOffreEmploiDAO         messageOffreDAO;
  @EJB private MessageCandidatureDAO         messageCandidatureDAO;
  //-----------------------------------------------------------------------------
  /**
   * Default constructor.
   */
  public ServiceEntreprise()
  {
    // TODO Auto-generated constructor stub
  }
  //-----------------------------------------------------------------------------
  @Override
  public Entreprise getEntreprise(int id)
  {
    return entrepriseDAO.findById(id);
  }
  //-----------------------------------------------------------------------------
  @Override
  public List<Entreprise> listeDesEntreprises()
  {
    return entrepriseDAO.findAll();
  }
  //-----------------------------------------------------------------------------
  @Override
  public Entreprise CreationEntreprise(Entreprise entreprise)
  {
    return entrepriseDAO.persist(entreprise);
  }
  //-----------------------------------------------------------------------------
  @Override
  public Entreprise UpdateEntreprise(Entreprise entreprise)
  {
    return entrepriseDAO.update(entreprise);
  }
  //-----------------------------------------------------------------------------
  @Override
  public void DeleteEntreprise(Entreprise entreprise)
  {
	
	for(OffreEmploi o : entreprise.getOffreEmplois()){
		
	    for(MessageOffreEmploi m : o.getMessageOffreEmplois()) {
	    	o.getMessageOffreEmplois().remove(m);
	    	messageOffreDAO.remove(m);
	    }
	    for(MessageCandidature m : o.getMessageCandidatures()) {
	    	o.getMessageCandidatures().remove(m);
	    	messageCandidatureDAO.remove(m);
	    }
	    entreprise.getOffreEmplois().remove(o);
	    offreDAO.remove(o);
	}
	
    entrepriseDAO.remove(entreprise);
  }
  //-----------------------------------------------------------------------------
}
