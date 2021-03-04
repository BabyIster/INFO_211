package eu.telecom_bretagne.cabinet_recrutement.service;

import javax.ejb.EJB;
import javax.ejb.LocalBean;
import javax.ejb.Stateless;

import eu.telecom_bretagne.cabinet_recrutement.data.dao.CandidatureDAO;
import eu.telecom_bretagne.cabinet_recrutement.data.dao.MessageOffreEmploiDAO;
import eu.telecom_bretagne.cabinet_recrutement.data.dao.OffreEmploiDAO;
import eu.telecom_bretagne.cabinet_recrutement.data.model.MessageCandidature;
import eu.telecom_bretagne.cabinet_recrutement.data.model.MessageOffreEmploi;

/**
 * Session Bean implementation class ServiceEntreprise
 * @author Philippe TANGUY
 */
@Stateless
@LocalBean
public class ServiceMessageOffre implements IServiceMessageOffre
{
  //-----------------------------------------------------------------------------
  @EJB private MessageOffreEmploiDAO         messageOffreDAO;
  @EJB private OffreEmploiDAO         offreEmploiDAO;
  @EJB private CandidatureDAO         candidatureDAO;
  //-----------------------------------------------------------------------------
  /**
   * Default constructor.
   */
  public ServiceMessageOffre()
  {
	  
    // TODO Auto-generated constructor stub
  }
  //-----------------------------------------------------------------------------
  @Override
  public void RemoveMessageOffre(MessageOffreEmploi message)
  {
    messageOffreDAO.remove(message);
  }
  //-----------------------------------------------------------------------------
  @Override
  public MessageOffreEmploi CreationMessageOffre(MessageOffreEmploi message) {
	  
	  message = messageOffreDAO.persist(message);
	  
	  message.getCandidature().getMessageOffreEmplois().add(message);
	  candidatureDAO.update(message.getCandidature());
	  
	  message.getOffreEmploi().getMessageOffreEmplois().add(message);
	  offreEmploiDAO.update(message.getOffreEmploi());
	  
	  return message;
  }
}