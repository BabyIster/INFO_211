package eu.telecom_bretagne.cabinet_recrutement.service;

import javax.ejb.EJB;
import javax.ejb.LocalBean;
import javax.ejb.Stateless;

import eu.telecom_bretagne.cabinet_recrutement.data.dao.CandidatureDAO;
import eu.telecom_bretagne.cabinet_recrutement.data.dao.MessageCandidatureDAO;
import eu.telecom_bretagne.cabinet_recrutement.data.dao.OffreEmploiDAO;
import eu.telecom_bretagne.cabinet_recrutement.data.model.MessageCandidature;

/**
 * Session Bean implementation class ServiceEntreprise
 * @author Philippe TANGUY
 */
@Stateless
@LocalBean
public class ServiceMessageCand implements IServiceMessageCand
{
  //-----------------------------------------------------------------------------
  @EJB private MessageCandidatureDAO         messageCandDAO;
  @EJB private OffreEmploiDAO         offreEmploiDAO;
  @EJB private CandidatureDAO         candidatureDAO;
  //-----------------------------------------------------------------------------
  /**
   * Default constructor.
   */
  public ServiceMessageCand()
  {
    // TODO Auto-generated constructor stub
  }
//-----------------------------------------------------------------------------
  @Override
  public MessageCandidature CreationMessageCand(MessageCandidature message) {
	  
	  message = messageCandDAO.persist(message);
	  
	  message.getCandidature().addMessageCandidature(message);
	  candidatureDAO.update(message.getCandidature());
	  
	  message.getOffreEmploi().addMessageCandidature(message);
	  offreEmploiDAO.update(message.getOffreEmploi());
	  
	  return message;
  }
}